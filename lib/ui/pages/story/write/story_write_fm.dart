// story_write_fm.dart
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/repository/story_repository.dart';
import 'package:path_provider/path_provider.dart';

final storyWriteProvider = AutoDisposeNotifierProvider<StoryWriteFM, AsyncValue<void>>(
  () {
    return StoryWriteFM();
  },
);

class StoryWriteFM extends AutoDisposeNotifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> uploadStory(File videoFile) async {
    final bucketBaseUrl = "https://minigrambucket.s3.ap-northeast-2.amazonaws.com/";
    state = const AsyncValue.loading();

    // try {

    // A) 썸네일 준비
    final File thumbnail = await _generateThumbnailInternal(videoFile.path);
    Logger().d("썸네일 준비 완료: ${thumbnail.path}");

    // B) presigned 요청 - 영상
    final presignedVideo = await StoryRepository().requestPresignedUrl("video/mp4");
    if (presignedVideo == null || presignedVideo["status"] != 200) {
      throw Exception("presigned(영상) 요청 실패");
    }
    Logger().d("presigned(영상) : $presignedVideo");
    final videoKey = presignedVideo["body"]["key"];
    final videoPresignedUrl = presignedVideo["body"]["presignedUrl"];

    // C) presigned 요청 - 썸네일(jpg)
    final presignedThumb = await StoryRepository().requestImagePresignedUrl("image/jpeg");
    if (presignedThumb == null || presignedThumb["status"] != 200) {
      throw Exception("presigned(썸네일) 요청 실패");
    }
    Logger().d("presigned(썸네일) : $presignedThumb");
    final thumbnailKey = presignedThumb["body"]["key"];
    final thumbnailPresignedUrl = presignedThumb["body"]["presignedUrl"];

    // D) S3 업로드 - 영상
    final videoSuccess = await StoryRepository().uploadToS3(videoPresignedUrl, videoFile);
    if (!videoSuccess) throw Exception("S3 업로드 실패(영상)");
    final videoUrl = "$bucketBaseUrl$videoKey";
    Logger().d("영상 업로드 완료: $videoSuccess");

    // E) S3 업로드 - 썸네일
    final thumbnailSuccess = await StoryRepository().uploadImgToS3(thumbnailPresignedUrl, thumbnail);
    if (!thumbnailSuccess) throw Exception("S3 업로드 실패(썸네일)");
    final thumbnailUrl = "$bucketBaseUrl$thumbnailKey";
    Logger().d("썸네일 업로드 완료: $thumbnailUrl");

    // F) 서버 등록
    final result = await StoryRepository().uploadStory(videoUrl, thumbnailUrl);
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

// 내부 썸네일 생성기 (첫 프레임, 720px 너비 유지)
Future<File> _generateThumbnailInternal(String videoPath) async {
  final dir = await getTemporaryDirectory();
  final outPath = '${dir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final cmd = '-y -ss 0 -i "$videoPath" -frames:v 1 -vf "scale=720:-1:flags=lanczos" -q:v 2 "$outPath"';
  final session = await FFmpegKit.execute(cmd);
  final file = File(outPath);
  if (!await file.exists()) {
    final rc = await session.getReturnCode();
    throw Exception('썸네일 생성 실패 (rc=$rc)');
  }
  return file;
}
