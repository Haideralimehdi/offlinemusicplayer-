import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation layer/controller/playlist_controller.dart';
import '../presentation layer/controller/themecontroller.dart';
import 'playlistdetailscreen.dart';

class PlaylistScreen extends StatelessWidget {

  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final playlistController = Get.find<PlaylistController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlists"),
      ),
      body: Obx(() {
        if (playlistController.playlists.isEmpty) {
          return const Center(
            child: Text(
              "No playlists yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: playlistController.playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlistController.playlists[index];

            return ListTile(
              title: Text(playlist.name),
              subtitle: Text("${playlist.songIds.length} songs"),
              onTap: () {
                // **Next Step me** playlist detail screen pe jayenge
                Get.to(() =>
                    PlaylistDetailScreen(playlistId: playlist.playlistId));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: ,
        onPressed: () {
          showCreatePlaylistDialog();
        },
        child: const Icon(Icons.add
        ),
      ),
    );
  }

  void showCreatePlaylistDialog() {
    final controller = Get.find<PlaylistController>();
    final nameController = TextEditingController();

    Get.defaultDialog(
      title: "Create Playlist",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Playlist Name",
            ),
          ),
        ],
      ),
      textConfirm: "Create",
      textCancel: "Cancel",
      onConfirm: () {
        final name = nameController.text.trim();
        if (name.isNotEmpty) {
          controller.createPlaylist(name);
          Get.back();
        }
      },
    );
  }
}
