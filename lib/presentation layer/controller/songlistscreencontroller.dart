import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'playlist_controller.dart';

class SongListController extends GetxController {
  final PlaylistController playlistController = Get.put(PlaylistController());

  final OnAudioQuery audioQuery = OnAudioQuery();

  final songs = <SongModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSongs();
  }

  // Load local songs
  Future<void> loadSongs() async {
    isLoading.value = true;

    List<SongModel> result = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );

    songs.assignAll(result);
    isLoading.value = false;
  }

  // Bottom Sheet Open Function
  void openAddToPlaylistSheet(SongModel song) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(() {
          final playlists = playlistController.playlists;

          return playlists.isEmpty
              ? const Text(
                  "No Playlists Created!",
                  style: TextStyle(fontSize: 18),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      title: Text(playlist.name),
                      trailing: const Icon(Icons.add),
                      onTap: () {
                        playlistController.addSongToPlaylist(
                          playlist.playlistId,
                          song.id,
                        );
                        Get.back();
                        Get.snackbar(
                          "Added",
                          "${song.title} added to ${playlist.name}",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    );
                  },
                );
        }),
      ),
      isScrollControlled: true,
    );
  }
}
