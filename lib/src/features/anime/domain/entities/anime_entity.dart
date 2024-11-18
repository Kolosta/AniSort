import 'package:equatable/equatable.dart';

class AnimeEntity extends Equatable {
  final int id;
  final String username;
  final String title;
  final String type;
  final String format;
  final String status;
  final int episodes;
  final int duration;
  final String source;
  final List<String> studios;
  final List<String> genres;
  final int popularity;
  final List<String> synonyms;
  final String bannerImage;
  final String coverImage;
  final String season;
  final int seasonYear;
  final int score;
  final int progress;
  final int repeat;
  final String notes;
  final DateTime startedAt;
  final DateTime completedAt;
  final DateTime updatedAt;
  final int localScore;

  const AnimeEntity({
    required this.id,
    required this.username,
    required this.title,
    required this.type,
    required this.format,
    required this.status,
    required this.episodes,
    required this.duration,
    required this.source,
    required this.studios,
    required this.genres,
    required this.popularity,
    required this.synonyms,
    required this.bannerImage,
    required this.coverImage,
    required this.season,
    required this.seasonYear,
    required this.score,
    required this.progress,
    required this.repeat,
    required this.notes,
    required this.startedAt,
    required this.completedAt,
    required this.updatedAt,
    required this.localScore,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        title,
        type,
        format,
        status,
        episodes,
        duration,
        source,
        studios,
        genres,
        popularity,
        synonyms,
        bannerImage,
        coverImage,
        season,
        seasonYear,
        score,
        progress,
        repeat,
        notes,
        startedAt,
        completedAt,
        updatedAt,
        localScore,
      ];
}