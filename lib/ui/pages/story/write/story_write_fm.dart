import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final storyWriteProvider = AutoDisposeNotifierProvider<StoryWriteFM, AsyncValue<void>>(() {
  return StoryWriteFM();
});

class StoryWriteFM extends AutoDisposeNotifier<AsyncValue<void>> {
  final Dio _dio = Dio();

  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  // presigned URL 요청
  Future<Map<String, dynamic>?> _requestPresignedUrl(String mimeType) async {
    final res = await _dio.post(
      "/s/api/upload",
      data: {
        "uploadType": "VIDEO",
        "mimeType": mimeType,
      },
    );
    if (res.data["status"] == 200) return res.data["body"];
    return null;
  }

  // S3 업로드
  Future<bool> _uploadToS3(String presignedUrl, File videoFile) async {
    try {
      final res = await _dio.put(
        presignedUrl,
        data: videoFile.openRead(),
        options: Options(
          headers: {"Content-Type": "video/mp4"},
        ),
      );
      return res.statusCode == 200;
    } catch (e) {
      Logger().e("S3 업로드 실패: $e");
      return false;
    }
  }

  // 서버에 최종 등록
  Future<Map<String, dynamic>?> _registerStory(String videoUrl) async {
    final res = await _dio.post(
      "/s/api/stories",
      data: {"videoUrl": videoUrl},
    );
    if (res.data["status"] == 200) return res.data["body"];
    return null;
  }

  // 전체 플로우 실행
  Future<void> uploadStory(File videoFile) async {
    state = const AsyncValue.loading();

    try {
      const mimeType = "video/mp4";
      final presigned = await _requestPresignedUrl(mimeType);
      if (presigned == null) throw Exception("presigned 요청 실패");

      final key = presigned["key"];
      final presignedUrl = presigned["presignedUrl"];

      final uploaded = await _uploadToS3(presignedUrl, videoFile);
      if (!uploaded) throw Exception("S3 업로드 실패");

      await _registerStory(key);

      state = const AsyncValue.data(null);
      Logger().d("스토리 등록 완료");
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
