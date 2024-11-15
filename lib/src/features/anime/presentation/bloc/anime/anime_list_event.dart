part of 'anime_list_bloc.dart';

abstract class AnimeListEvent extends Equatable {
  const AnimeListEvent();

  @override
  List<Object> get props => [];
}


class GetAnimeListEvent extends AnimeListEvent {
  final String username;
  final String type;
  final List<String> status;

  const GetAnimeListEvent({
    required this.username,
    required this.type,
    required this.status,
  });

  @override
  List<Object> get props => [username, type, status];
}