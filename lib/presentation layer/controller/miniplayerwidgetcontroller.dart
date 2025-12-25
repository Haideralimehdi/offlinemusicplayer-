import 'package:get/get.dart';

class MiniPlayerController extends GetxController {
  var songTitle = "No Song Playing".obs;
  var artist = "Unknown Artist".obs;
  var isPlaying = false.obs;

  void playSong(String title, String artistName) {
    songTitle.value = title;
    artist.value = artistName;
    isPlaying.value = true;
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }
}
