import 'package:hive/hive.dart';
import 'package:anilist_flutter/src/features/anime/data/models/anime_model.dart';

// AnimeAdapter
class AnimeAdapter extends TypeAdapter<AnimeModel> {
  @override
  final typeId = 1; // Ensure this is unique

  @override
  AnimeModel read(BinaryReader reader) {
    return AnimeModel(
      id: reader.readInt() ?? 0,
      username: reader.readString() ?? '',
      title: reader.readString() ?? '',
      type: reader.readString() ?? '',
      format: reader.readString() ?? '',
      status: reader.readString() ?? '',
      episodes: reader.readInt(),
      duration: reader.readInt(),
      source: reader.readString() ?? '',
      studios: (reader.readList()).cast<String>(),
      genres: (reader.readList()).cast<String>(),
      popularity: reader.readInt(),
      synonyms: (reader.readList()).cast<String>(),
      bannerImage: reader.readString() ?? '',
      coverImageExtraLarge: reader.readString() ?? '',
      coverImageLarge: reader.readString() ?? '',
      coverImageMedium: reader.readString() ?? '',
      coverImageColor: reader.readString() ?? '#edf1f5', // Default color
      season: reader.readString() ?? '',
      seasonYear: reader.readInt(),
      score: reader.readInt(),
      progress: reader.readInt(),
      repeat: reader.readInt(),
      notes: reader.readString() ?? '',
      startedAt: reader.read() as DateTime? ?? DateTime.now(),
      completedAt: reader.read() as DateTime? ?? DateTime.now(),
      updatedAt: reader.read() as DateTime? ?? DateTime.now(),
      localScore: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, AnimeModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.username);
    writer.writeString(obj.title);
    writer.writeString(obj.type);
    writer.writeString(obj.format);
    writer.writeString(obj.status);
    writer.writeInt(obj.episodes);
    writer.writeInt(obj.duration);
    writer.writeString(obj.source);
    writer.writeList(obj.studios);
    writer.writeList(obj.genres);
    writer.writeInt(obj.popularity);
    writer.writeList(obj.synonyms);
    writer.writeString(obj.bannerImage);
    writer.writeString(obj.coverImageExtraLarge);
    writer.writeString(obj.coverImageLarge);
    writer.writeString(obj.coverImageMedium);
    writer.writeString(obj.coverImageColor ?? '#edf1f5'); // Default color
    writer.writeString(obj.season);
    writer.writeInt(obj.seasonYear);
    writer.writeInt(obj.score);
    writer.writeInt(obj.progress);
    writer.writeInt(obj.repeat);
    writer.writeString(obj.notes);
    writer.write(obj.startedAt);
    writer.write(obj.completedAt);
    writer.write(obj.updatedAt);
    writer.writeInt(obj.localScore);
  }
}