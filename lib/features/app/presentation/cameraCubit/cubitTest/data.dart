import 'package:hive/hive.dart';

class GameData {
  int level;
  int score;

  GameData({required this.level, required this.score});
}

class GameDataAdapter extends TypeAdapter<GameData> {
  @override
  final int typeId = 0;

  @override
  GameData read(BinaryReader reader) {
    final level = reader.readInt();
    final score = reader.readInt();
    return GameData(level: level, score: score);
  }

  @override
  void write(BinaryWriter writer, GameData obj) {
    writer.writeInt(obj.level);
    writer.writeInt(obj.score);
  }
}
