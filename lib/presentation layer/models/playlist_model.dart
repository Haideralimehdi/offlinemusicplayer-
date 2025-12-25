import 'package:hive/hive.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class PlaylistModel extends HiveObject {
  @HiveField(0)
  int playlistId;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<int> songIds;

  PlaylistModel({
    required this.playlistId,
    required this.name,
    required this.songIds,
  });
}
