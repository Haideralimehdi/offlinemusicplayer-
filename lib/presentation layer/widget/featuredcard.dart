import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player2/presentation%20layer/utils/apptheme.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../views/fullplayerscreen.dart';
import '../controller/playercontroller.dart';
import '../controller/themecontroller.dart';

class FeaturedAlbumWidget extends StatelessWidget {
  const FeaturedAlbumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerController());

    final size = MediaQuery.of(context).size;
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    final double cardHeight = size.height * 0.11;

    return Obx(() {
      final song = controller.currentSong.value;

      return GestureDetector(
        onTap:
            song == null ? null : () => Get.to(() => const FullPlayerScreen()),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.015,
          ),
          padding: EdgeInsets.all(size.width * 0.03),
          height: cardHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              // color: themeController.,
              gradient: AppTheme.backgroundGradient
              ),
          child: Row(
            children: [
              // ✅ OFFLINE Album Art / Placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: song == null
                    ? Container(
                        width: 55,
                        height: 55,
                        color: Colors.black26,
                        child:
                            const Icon(Icons.music_note, color: Colors.white),
                      )
                    : QueryArtworkWidget(
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        artworkWidth: 55,
                        artworkHeight: 55,
                        nullArtworkWidget: Container(
                          width: 55,
                          height: 55,
                          color: Colors.black26,
                          child:
                              const Icon(Icons.music_note, color: Colors.white),
                        ),
                      ),
              ),

              const SizedBox(width: 12),

              // ✅ Song Info (Same UI always)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song?.title ?? "No song playing",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      song?.artist ?? "Select a song",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Controls (Disable when no song)
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: song == null ? null : controller.playPrevious,
              ),

              IconButton(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: song == null ? null : controller.togglePlayPause,
              ),

              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: song == null ? null : controller.playNext,
              ),
            ],
          ),
        ),
      );
    });
  }
}
