import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/post/write/post_write_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:minigram/ui/pages/story/write/story_write_fm.dart';
import 'package:minigram/ui/pages/story/write/story_write_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class ProfileGridBuilder extends ConsumerWidget {
  final bool isStoryTab;
  final ProfileModel profileModel;

  const ProfileGridBuilder({
    super.key,
    this.isStoryTab = false,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyList = profileModel.storyListObject.storyList;
    final postList = profileModel.postListObject.postList;

    if (isStoryTab) {
      return CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == storyList.length) {
                  return _AddBox(context, ref);
                } else {
                  final item = storyList[index];
                  return MGridItem(
                    imageUrl: item.thumbnailUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StoryDetailPage(storyId: item.storyId),
                        ),
                      );
                    },
                  );
                }
              },
              childCount: storyList.length + 1,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MSize.kRatio.aspect34,
              crossAxisSpacing: MSize.kGap.xxxs,
              mainAxisSpacing: MSize.kGap.xxxs,
            ),
          ),
        ],
      );
    } else {
      return CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == postList.length) {
                  return _AddBox(context, ref);
                } else {
                  final item = postList[index];
                  return MGridItem(
                    imageUrl: item.postImageUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailPage(postId: item.postId),
                        ),
                      );
                    },
                  );
                }
              },
              childCount: postList.length + 1,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MSize.kRatio.aspect34,
              crossAxisSpacing: MSize.kGap.xxxs,
              mainAxisSpacing: MSize.kGap.xxxs,
            ),
          ),
        ],
      );
    }
  }

  Material _AddBox(BuildContext context, WidgetRef ref) {
    final ImagePicker picker = ImagePicker();

    Future<void> _pickVideo() async {
      final XFile? video = await picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 60),
      );

      if (video != null) {
        ref.read(storyWriteProvider.notifier).uploadStory(File(video.path));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StoryWritePage(videoPath: video.path),
          ),
        );
      }
    }

    Future<void> _pickImages() async {
      final List<XFile> images = await picker.pickMultiImage(
        imageQuality: 85,
        limit: 10,
      );

      if (images.isNotEmpty) {
        final paths = images.map((img) => img.path).toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostWritePage(imagePaths: paths),
          ),
        );
      }
    }

    return Material(
      color: MColor.kBackGround.lightGray,
      child: InkWell(
        onTap: () async {
          if (isStoryTab) {
            await _pickVideo();
          } else {
            await _pickImages();
          }
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
