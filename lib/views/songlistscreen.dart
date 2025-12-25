import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../presentation layer/controller/playlist_controller.dart';
import '../presentation layer/controller/audiocontroller.dart';
import '../presentation layer/controller/playercontroller.dart';
import '../presentation layer/controller/songlistscreencontroller.dart';
import '../presentation layer/controller/usercontroller.dart';
import '../presentation layer/utils/apptheme.dart';
import '../presentation layer/widget/miniplayerwidget.dart';
import 'fullplayerscreen.dart';
import 'playlistscreen.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  @override
  Widget build(BuildContext context) {
    final AudioController controller = Get.find<AudioController>();
    final PlayerController playerController = Get.find<PlayerController>();
    final SongListController songListController = Get.put(SongListController());
    final UserController userController = Get.put(UserController());

    // final playlistController = Get.put(PlaylistController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        title: const Text(
          'MuzikFlow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      drawer: Drawer(
        child: Column(
          children: [
            /// 🔥 PROFILE HEADER
            Obx(() {
              final user = userController.user.value;

              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: AppTheme.backgroundGradient,
                ),

                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      user != null ? FileImage(File(user.imagePath)) : null,
                  child: user == null
                      ? const Icon(Icons.person, size: 45, color: Colors.black)
                      : null,
                ),

                /// 👤 USER NAME (Bigger + Bold)
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    user?.name ?? "Guest User",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),

                /// 📧 OPTIONAL SUBTITLE
                accountEmail: const Text(
                  "Welcome back 👋",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              );
            }),

            /// 🏠 HOME
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),

            /// 🎵 PLAYLISTS
            ListTile(
              leading: const Icon(Icons.playlist_play, color: Colors.black),
              title: const Text(
                "Playlists",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Get.back();
                Get.to(() => const PlaylistScreen());
              },
            ),

            const Divider(thickness: 1),

            /// ⚙ SETTINGS
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: MiniPlayer(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.songs.isEmpty) {
          return const Center(child: Text("No Songs Found"));
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.015,
          ),
          itemCount: controller.songs.length,
          separatorBuilder: (_, __) => SizedBox(height: size.height * 0.01),
          itemBuilder: (context, index) {
            final song = controller.songs[index];

            final durationMs = song.duration ?? 0;
            final duration =
                _formatDuration(Duration(milliseconds: durationMs));

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onLongPress: () {
                songListController.openAddToPlaylistSheet(song);
              },
              onTap: () {
                playerController.setPlaylist(controller.songs);
                playerController.playSong(song);
                Get.to(() => const FullPlayerScreen());
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // ✅ Album Art
                    QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: size.width * 0.14,
                      artworkWidth: size.width * 0.14,
                      artworkBorder: BorderRadius.circular(size.width * 0.02),
                      nullArtworkWidget: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                        ),
                        child: const Icon(Icons.music_note),
                      ),
                    ),

                    SizedBox(width: size.width * 0.04),

                    // ✅ Song Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title ?? 'Unknown',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: size.width * 0.043,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: size.height * 0.004),
                          Text(
                            song.artist ?? 'Unknown Artist',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: size.width * 0.033,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ Duration
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: size.width * 0.032,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(width: size.width * 0.02),

                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// mm:ss formatter
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
