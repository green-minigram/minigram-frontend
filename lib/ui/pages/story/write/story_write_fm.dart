// story_write_fm.dart
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/repository/story_repository.dart';

final storyWriteProvider = AutoDisposeNotifierProvider<StoryWriteFM, AsyncValue<void>>(
  () {
    return StoryWriteFM();
  },
);

class StoryWriteFM extends AutoDisposeNotifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> uploadStory(File videoFile) async {
    state = const AsyncValue.loading();

    // try {
    // 1. presigned url 요청
    final presigned = await StoryRepository().requestPresignedUrl("video/mp4");
    if (presigned == null || presigned["status"] != 200) {
      throw Exception("presigned 요청 실패");
    }
    Logger().d("presigned url 호출 끝 : $presigned");

    final body = presigned["body"];
    final key = body["key"];
    final presignedUrl = body["presignedUrl"];

    // 2. s3 업로드
    final success = await StoryRepository().uploadToS3(presignedUrl, videoFile);
    if (!success) throw Exception("S3 업로드 실패");
    Logger().d("s3 업로드 호출 끝 : $success");

    // 3. 서버 등록
    final result = await StoryRepository().uploadStory(key);
    if (result == null || result["status"] != 200) {
      throw Exception("스토리 등록 실패");
    }
    Logger().d("서버 등록 끝 : $result");

    Logger().d("스토리 등록 성공: ${result["body"]}");
    state = const AsyncValue.data(null);
    // } catch (e, st) {
    //   state = AsyncValue.error(e, st);
    //   Logger().e("스토리 업로드 실패");
    // }
  }
}
