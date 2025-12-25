import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../presentation layer/controller/playercontroller.dart';
import '../presentation layer/utils/apptheme.dart';
import 'playlistscreen.dart';

class FullPlayerScreen extends StatelessWidget {
  const FullPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PlayerController controller = Get.find<PlayerController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,

      // ✅ PROFESSIONAL APP BAR (Your Design Applied)
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: AppTheme.icon,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "MuzikFlow",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => PlaylistScreen());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Icon(
                color: AppTheme.icon,
                Icons.playlist_add,
                size: 28,
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        final song = controller.currentSong.value;
        if (song == null) return const SizedBox();

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                const Spacer(),

                // ✅ ALBUM ART (Now More Premium Look)
                Container(
                  height: size.width * 0.78,
                  width: size.width * 0.78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Colors.black54, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 25,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Container(
                        color: Colors.grey.shade900,
                        child: const Icon(
                          Icons.music_note,
                          size: 140,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // ✅ TITLE
                Text(
                  song.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.058,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                // ✅ ARTIST
                Text(
                  song.artist ?? "Unknown Artist",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: size.width * 0.04,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // ✅ SLIDER (More Clean Look)
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 7),
                  ),
                  child: Slider(
                    value: controller.position.value.inSeconds.toDouble(),
                    max: controller.duration.value.inSeconds == 0
                        ? 1
                        : controller.duration.value.inSeconds.toDouble(),
                    onChanged: (value) {
                      controller.seek(Duration(seconds: value.toInt()));
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey.shade700,
                  ),
                ),

                // ✅ TIME ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(controller.position.value),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      _formatDuration(controller.duration.value),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.045),

                // ✅ CONTROLS (Professional Spacing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: size.width * 0.11,
                      onPressed: controller.playPrevious,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white24,
                            blurRadius: 18,
                          )
                        ],
                      ),
                      child: IconButton(
                        iconSize: size.width * 0.19,
                        onPressed: controller.togglePlayPause,
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: size.width * 0.11,
                      onPressed: controller.playNext,
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// ✅ FORMAT mm:ss
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
