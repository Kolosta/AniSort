import 'dart:ui';

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
  final String coverImageExtraLarge;
  final String coverImageLarge;
  final String coverImageMedium;
  final String? coverImageColor; // Nullable
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
    required this.coverImageExtraLarge,
    required this.coverImageLarge,
    required this.coverImageMedium,
    this.coverImageColor,
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

  Color getCoverImageColor() {
    return coverImageColor != null
        ? Color(int.parse(coverImageColor!.replaceFirst('#', '0xff')))
        : const Color(0xffedf1f5); // Default color
  }

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
        coverImageExtraLarge,
        coverImageLarge,
        coverImageMedium,
        coverImageColor,
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