part of 'anime_list_bloc.dart';

abstract class AnimeListState extends Equatable {
  const AnimeListState();

  @override
  List<Object> get props => [];
}

class AnimeListInitialState extends AnimeListState {}

class AnimeListLoadingState extends AnimeListState {}

class AnimeListSuccessState extends AnimeListState {
  final List<AnimeEntity> animeList;

  const AnimeListSuccessState(this.animeList);

  @override
  List<Object> get props => [animeList];
}

class AnimeListFailureState extends AnimeListState {
  final String message;

  const AnimeListFailureState(this.message);

  @override
  List<Object> get props => [message];
}