import '../../domain/entities/anime_entity.dart';

// AnimeModel
class AnimeModel extends AnimeEntity {
  final int localScore;

  const AnimeModel({
    required super.id,
    required super.username,
    required super.title,
    required super.type,
    required super.format,
    required super.status,
    required super.episodes,
    required super.duration,
    required super.source,
    required super.studios,
    required super.genres,
    required super.popularity,
    required super.synonyms,
    required super.bannerImage,
    required super.coverImage,
    required super.season,
    required super.seasonYear,
    required super.score,
    required super.progress,
    required super.repeat,
    required super.notes,
    required super.startedAt,
    required super.completedAt,
    required super.updatedAt,
    required this.localScore,
  }) : super(
    localScore: localScore,
  );


  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    final media = json['media'];
    return AnimeModel(
      id: media['id'] ?? 0,
      username: json['username'] ?? '',
      title: media['title']['romaji'] ?? '',
      type: media['type'] ?? '',
      format: media['format'] ?? '',
      status: json['status'] ?? '',
      episodes: media['episodes'] ?? 0,
      duration: media['duration'] ?? 0,
      source: media['source'] ?? '',
      studios: (media['studios']['nodes'] as List<dynamic>?)
          ?.map((studio) => studio['name'] as String)
          .toList() ??
          [],
      genres: List<String>.from(media['genres'] ?? []),
      popularity: media['popularity'] ?? 0,
      synonyms: List<String>.from(media['synonyms'] ?? []),
      bannerImage: media['bannerImage'] ?? '',
      coverImage: media['coverImage']['extraLarge'] ?? '',
      season: media['season'] ?? '',
      seasonYear: media['seasonYear'] ?? 0,
      score: json['score'] ?? 0,
      progress: json['progress'] ?? 0,
      repeat: json['repeat'] ?? 0,
      notes: json['notes'] ?? '',
      startedAt: json['startedAt'] != null
          ? DateTime(
        json['startedAt']['year'] ?? 0,
        json['startedAt']['month'] ?? 1,
        json['startedAt']['day'] ?? 1,
      )
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime(
        json['completedAt']['year'] ?? 0,
        json['completedAt']['month'] ?? 1,
        json['completedAt']['day'] ?? 1,
      )
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] * 1000)
          : DateTime.now(),
      localScore: json['localScore'] ?? 0,
    );
  }

  static List<AnimeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AnimeModel.fromJson(json)).toList();
  }


  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      format: map['format'] ?? '',
      status: map['status'] ?? '',
      episodes: map['episodes'] ?? 0,
      duration: map['duration'] ?? 0,
      source: map['source'] ?? '',
      studios: List<String>.from(map['studios'] ?? []),
      genres: List<String>.from(map['genres'] ?? []),
      popularity: map['popularity'] ?? 0,
      synonyms: List<String>.from(map['synonyms'] ?? []),
      bannerImage: map['bannerImage'] ?? '',
      coverImage: map['coverImage'] ?? '',
      season: map['season'] ?? '',
      seasonYear: map['seasonYear'] ?? 0,
      score: map['score'] ?? 0,
      progress: map['progress'] ?? 0,
      repeat: map['repeat'] ?? 0,
      notes: map['notes'] ?? '',
      startedAt: map['startedAt'] != null ? DateTime.parse(map['startedAt']) : DateTime.now(),
      completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
      localScore: map['localScore'] ?? 0,
    );
  }

  static List<AnimeModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((json) => AnimeModel.fromMap(json)).toList();
  }
  //OLD
  // static List<AnimeModel> fromMapList(List<Map<String, dynamic>> mapList) {
  //   return mapList.map((map) => AnimeModel.fromMap(map)).toList();
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'type': type,
      'format': format,
      'status': status,
      'episodes': episodes,
      'duration': duration,
      'source': source,
      'studios': studios,
      'genres': genres,
      'popularity': popularity,
      'synonyms': synonyms,
      'bannerImage': bannerImage,
      'coverImage': coverImage,
      'season': season,
      'seasonYear': seasonYear,
      'score': score,
      'progress': progress,
      'repeat': repeat,
      'notes': notes,
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'localScore': localScore,
    };
  }

  static List<Map<String, dynamic>> toMapList(List<AnimeModel> animeList) {
    return animeList.map((e) => e.toMap()).toList();
  }


  AnimeModel copyWith({
    int? id,
    String? username,
    String? title,
    String? type,
    String? format,
    String? status,
    int? episodes,
    int? duration,
    String? source,
    List<String>? studios,
    List<String>? genres,
    int? popularity,
    List<String>? synonyms,
    String? bannerImage,
    String? coverImage,
    String? season,
    int? seasonYear,
    int? score,
    int? progress,
    int? repeat,
    String? notes,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? updatedAt,
    int? localScore,
  }) {
    return AnimeModel(
      id: id ?? this.id,
      username: username ?? this.username,
      title: title ?? this.title,
      type: type ?? this.type,
      format: format ?? this.format,
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      duration: duration ?? this.duration,
      source: source ?? this.source,
      studios: studios ?? this.studios,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      synonyms: synonyms ?? this.synonyms,
      bannerImage: bannerImage ?? this.bannerImage,
      coverImage: coverImage ?? this.coverImage,
      season: season ?? this.season,
      seasonYear: seasonYear ?? this.seasonYear,
      score: score ?? this.score,
      progress: progress ?? this.progress,
      repeat: repeat ?? this.repeat,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      localScore: localScore ?? this.localScore,
    );
  }


  int compareTo(AnimeModel other) {
    if (score != other.score) {
      return other.score.compareTo(score); // Higher scores first
    }
    return title.compareTo(other.title); // Alphabetical order
  }

  static AnimeModel fromEntity(AnimeEntity entity) {
    return AnimeModel(
      id: entity.id,
      username: entity.username,
      title: entity.title,
      type: entity.type,
      format: entity.format,
      status: entity.status,
      episodes: entity.episodes,
      duration: entity.duration,
      source: entity.source,
      studios: entity.studios,
      genres: entity.genres,
      popularity: entity.popularity,
      synonyms: entity.synonyms,
      bannerImage: entity.bannerImage,
      coverImage: entity.coverImage,
      season: entity.season,
      seasonYear: entity.seasonYear,
      score: entity.score,
      progress: entity.progress,
      repeat: entity.repeat,
      notes: entity.notes,
      startedAt: entity.startedAt,
      completedAt: entity.completedAt,
      updatedAt: entity.updatedAt,
      localScore: entity.localScore,
    );
  }

  AnimeEntity toEntity() {
    return AnimeEntity(
      id: id,
      username: username,
      title: title,
      type: type,
      format: format,
      status: status,
      episodes: episodes,
      duration: duration,
      source: source,
      studios: studios,
      genres: genres,
      popularity: popularity,
      synonyms: synonyms,
      bannerImage: bannerImage,
      coverImage: coverImage,
      season: season,
      seasonYear: seasonYear,
      score: score,
      progress: progress,
      repeat: repeat,
      notes: notes,
      startedAt: startedAt,
      completedAt: completedAt,
      updatedAt: updatedAt,
      localScore: localScore,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'username': username,
  //     'title': title,
  //     'type': type,
  //     'format': format,
  //     'status': status,
  //     'episodes': episodes,
  //     'duration': duration,
  //     'source': source,
  //     'studios': studios,
  //     'genres': genres,
  //     'popularity': popularity,
  //     'synonyms': synonyms,
  //     'bannerImage': bannerImage,
  //     'coverImage': coverImage,
  //     'season': season,
  //     'seasonYear': seasonYear,
  //     'score': score,
  //     'progress': progress,
  //     'repeat': repeat,
  //     'notes': notes,
  //     'startedAt': startedAt.toIso8601String(),
  //     'completedAt': completedAt.toIso8601String(),
  //     'updatedAt': updatedAt.toIso8601String(),
  //     'localScore': localScore,
  //   };
  // }
}