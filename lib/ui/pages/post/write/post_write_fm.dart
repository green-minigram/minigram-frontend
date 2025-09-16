import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/repository/post_repository.dart';

final postWriteProvider = NotifierProvider<PostWriteFM, AsyncValue<void>>(
  () {
    return PostWriteFM();
  },
);

class PostWriteFM extends Notifier<AsyncValue<void>> {
  List<String> uploadedUrls = [];

  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  /// 이미지들을 S3에 업로드만 해두는 메서드
  Future<void> uploadImagesToS3(List<File> imageFiles) async {
    state = const AsyncValue.loading();

    final bucketBaseUrl = "https://minigram-2025.s3.ap-northeast-2.amazonaws.com/";
    uploadedUrls.clear();

    for (final file in imageFiles) {
      final presigned = await PostRepository().requestPresignedUrl("image/jpeg");
      if (presigned == null || presigned["status"] != 200) {
        throw Exception("presigned 요청 실패");
      }
      Logger().d("presigned url 호출 끝 : $presigned");

      final body = presigned["body"];
      final key = body["key"];
      final presignedUrl = body["presignedUrl"];

      final success = await PostRepository().uploadToS3(presignedUrl, file);
      if (!success) throw Exception("S3 업로드 실패");
      Logger().d("s3 업로드 성공: $key");

      uploadedUrls.add("$bucketBaseUrl$key");
    }

    Logger().d("전체 이미지 S3 업로드 완료: $uploadedUrls");
    state = const AsyncValue.data(null);
  }

  /// 서버에 게시글 등록 (버튼 누를 때 호출)
  Future<void> registerPost(String content) async {
    state = const AsyncValue.loading();

    if (uploadedUrls.isEmpty) {
      Logger().e("업로드된 이미지 없음: $uploadedUrls");
      throw Exception("업로드된 이미지가 없습니다");
    }

    final result = await PostRepository().uploadPost(
      imageUrls: uploadedUrls,
      content: content,
    );

    Logger().d("게시글 등록 응답 원본: $result");

    if (result == null) {
      Logger().e("게시글 등록 실패: result == null");
      throw Exception("게시글 등록 실패");
    }

    if (result["status"] != 200) {
      Logger().e("게시글 등록 실패: status=${result["status"]}, body=${result["body"]}");
      throw Exception("게시글 등록 실패");
    }

    Logger().d("게시글 등록 성공: ${result["body"]}");
    state = const AsyncValue.data(null);
  }
}
