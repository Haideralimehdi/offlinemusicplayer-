import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final AudioPlayer _player = AudioPlayer();

  final currentSong = Rxn<SongModel>();
  final isPlaying = false.obs;
  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;

  final playlist = <SongModel>[].obs;
  final currentIndex = 0.obs;

  AudioPlayer get player => _player;

  @override
  void onInit() {
    super.onInit();

    _player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    _player.durationStream.listen((d) {
      duration.value = d ?? Duration.zero;
    });

    _player.positionStream.listen((p) {
      position.value = p;
    });
  }

  /// ✅ ALWAYS SET PLAYLIST FIRST
  void setPlaylist(List<SongModel> songs) {
    playlist.assignAll(songs);
  }

  /// ✅ SAFE PLAY
  Future<void> playSong(SongModel song) async {
    if (playlist.isEmpty) {
      print("❌ Playlist empty — Next/Prev disabled");
    }

    currentSong.value = song;

    final index = playlist.indexWhere((element) => element.id == song.id);

    if (index != -1) {
      currentIndex.value = index;
    }

    await _player.setAudioSource(
      AudioSource.uri(Uri.parse(song.data)),
    );

    _player.play();
  }

  void togglePlayPause() {
    _player.playing ? _player.pause() : _player.play();
  }

  void seek(Duration newPos) {
    _player.seek(newPos);
  }

  /// ✅ NEXT (SAFE)
  void playNext() {
    if (playlist.isEmpty) return;

    if (currentIndex.value < playlist.length - 1) {
      currentIndex.value++;
      playSong(playlist[currentIndex.value]);
    } else {
      // ignore: avoid_print
      print("✅ Last song reached");
    }
  }

  /// ✅ PREVIOUS (SAFE)
  void playPrevious() {
    if (playlist.isEmpty) return;

    if (currentIndex.value > 0) {
      currentIndex.value--;
      playSong(playlist[currentIndex.value]);
    }
  }

  void stop() {
    _player.stop();
  }
}
