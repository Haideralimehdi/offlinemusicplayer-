import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/themecontroller.dart';

class SongTileWidget extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;
  final int songId;

  const SongTileWidget({
    super.key,
    required this.title,
    required this.artist,
    required this.duration,
    required this.songId,
  });

  @override
  Widget build(BuildContext context) {
        final ThemeController themeController = Get.put(ThemeController());

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.06,
        vertical: size.height * 0.012,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: size.width * 0.07,
            backgroundColor: Colors.grey.shade300,
            child: ClipOval(
              child: QueryArtworkWidget(
                id: songId,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.cover,
                nullArtworkWidget: Icon(
                  Icons.music_note,
                  color: Colors.grey,
                  size: size.width * 0.07,
                ),
              ),
            ),
          ),

          SizedBox(width: size.width * 0.04),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeController.primaryText,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    
                    fontSize: size.width * 0.035,
                    color: themeController.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: size.width * 0.02),

          Text(
            duration,
            style: TextStyle(
              fontSize: size.width * 0.035,
              color: Colors.grey,
            ),
          ),

          SizedBox(width: size.width * 0.02),

          Icon(
            Icons.more_vert,
            size: size.width * 0.06,
            color: themeController.icon,
          ),
        ],
      ),
    );
  }
}
