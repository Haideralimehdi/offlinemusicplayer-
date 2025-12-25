import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../presentation layer/controller/audiocontroller.dart';
import '../presentation layer/controller/playercontroller.dart';
import '../presentation layer/controller/playlist_controller.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final int playlistId;

  const PlaylistDetailScreen({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final playlistController = Get.find<PlaylistController>();
    final playerController = Get.find<PlayerController>();
    final audioController = Get.find<AudioController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final playlist = playlistController.playlists.firstWhere(
              (p) => p.playlistId == playlistId,
              orElse: () => throw "Playlist not found");
          return Text(playlist.name);
        }),
      ),
      body: Obx(() {
        final playlist = playlistController.playlists.firstWhere(
            (p) => p.playlistId == playlistId,
            orElse: () => throw "Playlist not found");

        if (playlist.songIds.isEmpty) {
          return const Center(
            child: Text(
              "No songs in this playlist",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // // Convert songIds → SongModel
        // final allSongs = Get.find<PlayerController>().playlist; // device songs
        // final songsInPlaylist = allSongs
        //     .where((song) => playlist.songIds.contains(song.id))
        //     .toList();
        // ✅ Correct source: device songs
        final songsInPlaylist = audioController.songs
            .where((song) => playlist.songIds.contains(song.id))
            .toList();

        return ListView.builder(
          itemCount: songsInPlaylist.length,
          itemBuilder: (context, index) {
            final song = songsInPlaylist[index];

            return ListTile(
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
              ),
              title: Text(song.title),
              subtitle: Text(song.artist ?? "Unknown"),
              onTap: () {
                // Play selected song
                playerController.setPlaylist(songsInPlaylist);
                playerController.playSong(song);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  playlistController.removeSongFromPlaylist(
                      playlist.playlistId, song.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
