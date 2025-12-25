import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player2/views/fullplayerscreen.dart';

import '../../views/songlistscreen.dart';
import '../controller/audiocontroller.dart';
import '../controller/playercontroller.dart';
import '../controller/songlistscreencontroller.dart';
import '../controller/themecontroller.dart';
import '../utils/apptheme.dart';
import 'songtilewidget.dart';

class AllSongsWidget extends StatefulWidget {
  const AllSongsWidget({super.key});

  @override
  State<AllSongsWidget> createState() => _AllSongsWidgetState();
}

class _AllSongsWidgetState extends State<AllSongsWidget> {
  @override
  Widget build(BuildContext context) {
    final AudioController c = Get.find<AudioController>();
    final PlayerController playerController = Get.put(PlayerController());
    final ThemeController themeController = Get.put(ThemeController());
    final SongListController songListController =
        Get.put(SongListController());
    final size = MediaQuery.of(context).size;

    return Obx(() {
      if (c.isLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (c.error.value != null) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: Center(child: Text('Error: ${c.error.value}')),
        );
      }

      if (c.songs.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: Center(child: Text('No songs found on device')),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.01,
            ),
            child: Row(children: [
              Text(
                "All Songs",
                style: TextStyle(
                  color: themeController.primaryText,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SongListScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.icon,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ]),
          ),

          // list
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: c.songs.length,
            separatorBuilder: (_, __) => SizedBox(height: size.height * 0.005),
            itemBuilder: (context, index) {
              final song = c.songs[index];

              // convert duration milliseconds to mm:ss or display artist
              final durationMs = song.duration ?? 0;
              final duration =
                  _formatDuration(Duration(milliseconds: durationMs));

              return GestureDetector(
                onLongPress: () {
                  songListController.openAddToPlaylistSheet(song);
                },
                onTap: () {
                  playerController.setPlaylist(c.songs); // ✅ STORAGE list here
                  playerController.playSong(song); // ✅ then play
                  Get.to(() => const FullPlayerScreen());
                },
                child: SongTileWidget(
                  title: song.title ?? 'Unknown',
                  artist: song.artist ?? 'Unknown',
                  duration: duration,
                  songId: song.id,
                ),
              );
            },
          ),
        ],
      );
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
