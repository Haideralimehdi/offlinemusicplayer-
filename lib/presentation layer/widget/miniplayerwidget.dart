import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../views/fullplayerscreen.dart';
import '../controller/playercontroller.dart';
// import '../controllers/player_controller.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PlayerController controller = Get.find<PlayerController>();

    return Obx(() {
      final song = controller.currentSong.value;

      // ✅ Agar koi song play nahi ho raha → mini player hide
      if (song == null) return const SizedBox();

      return GestureDetector(
        onTap: () => Get.to(
          () => const FullPlayerScreen(),
        ),
        child: Container(
          height: size.height * 0.095,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              // ✅ REAL ALBUM ART
              QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(100),
                artworkHeight: size.width * 0.14,
                artworkWidth: size.width * 0.14,
                nullArtworkWidget: CircleAvatar(
                  radius: size.width * 0.07,
                  child: const Icon(Icons.music_note),
                ),
              ),

              SizedBox(width: size.width * 0.04),

              // ✅ SONG TITLE + ARTIST (REAL DATA)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      song.artist ?? "Unknown Artist",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
                IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  size: size.width * 0.08,
                ),
                onPressed: controller.playPrevious,
              ),
              // ✅ PLAY / PAUSE (REAL STATE)
              IconButton(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  size: size.width * 0.08,
                ),
                onPressed: controller.togglePlayPause,
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  size: size.width * 0.08,
                ),
                onPressed: controller.playNext,
              ),
            ],
          ),
        ),
      );
    });
  }
}
