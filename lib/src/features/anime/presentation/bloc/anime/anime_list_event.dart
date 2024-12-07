part of 'anime_list_bloc.dart';

abstract class AnimeListEvent extends Equatable {
  const AnimeListEvent();

  @override
  List<Object> get props => [];
}


class ImportAnimeListFromAPIEvent extends AnimeListEvent {
  final String username;
  final String type;
  final List<String> status;

  const ImportAnimeListFromAPIEvent({
    required this.username,
    required this.type,
    required this.status,
  });

  @override
  List<Object> get props => [username, type, status];
}


class GetLocalAnimeListEvent extends AnimeListEvent {}


class GetAnimeListFromApiEvent extends AnimeListEvent {
  final String username;
  final String type;
  final List<String> status;

  const GetAnimeListFromApiEvent({
    required this.username,
    required this.type,
    required this.status,
  });

  @override
  List<Object> get props => [username, type, status];
}

class UpdateAnimeListEvent extends AnimeListEvent {
  final List<AnimeEntity> updatedList;

  const UpdateAnimeListEvent(this.updatedList);

  @override
  List<Object> get props => [updatedList];
}

class ValidateAnimeOrderEvent extends AnimeListEvent {
  final List<AnimeModel> animeList;

  const ValidateAnimeOrderEvent(this.animeList);

  @override
  List<Object> get props => [animeList];
}

class UploadAnimeListToFirebaseEvent extends AnimeListEvent {}