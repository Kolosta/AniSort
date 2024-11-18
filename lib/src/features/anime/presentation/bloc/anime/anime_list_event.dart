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

class UploadAnimeListToFirebaseEvent extends AnimeListEvent {}