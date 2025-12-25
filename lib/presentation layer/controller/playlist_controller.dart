import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/playlist_model.dart';

class PlaylistController extends GetxController {
  late Box<PlaylistModel> playlistBox;

  // Observable list for UI
  final playlists = <PlaylistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    playlistBox = Hive.box<PlaylistModel>('playlists');
    loadPlaylists();
  }

  // Load all playlists
  void loadPlaylists() {
    playlists.assignAll(playlistBox.values.toList());
  }

  // Create a new playlist
  Future<void> createPlaylist(String name) async {
    final newPlaylist = PlaylistModel(
      playlistId: DateTime.now().millisecondsSinceEpoch,
      name: name,
      songIds: [],
    );

    await playlistBox.add(newPlaylist);
    loadPlaylists();
  }

  // Add song inside playlist
  Future<void> addSongToPlaylist(int playlistId, int songId) async {
    final playlist = playlists.firstWhere((p) => p.playlistId == playlistId);

    if (!playlist.songIds.contains(songId)) {
      playlist.songIds.add(songId);
      playlist.save();
      loadPlaylists();
    }
  }

  // Remove song from playlist
  Future<void> removeSongFromPlaylist(int playlistId, int songId) async {
    final playlist = playlists.firstWhere((p) => p.playlistId == playlistId);

    playlist.songIds.remove(songId);
    playlist.save();
    loadPlaylists();
  }
}
