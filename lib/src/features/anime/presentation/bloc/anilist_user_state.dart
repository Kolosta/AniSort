part of 'anilist_user_bloc.dart';

abstract class AnilistUserState extends Equatable {
  const AnilistUserState();

  @override
  List<Object> get props => [];
}

class AnilistUserInitialState extends AnilistUserState {}

class AnilistUserLoadingState extends AnilistUserState {}

class AnilistUserSuccessState extends AnilistUserState {
  final AnilistUserEntity user;

  const AnilistUserSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AnilistUserFailureState extends AnilistUserState {
  final String message;

  const AnilistUserFailureState(this.message);

  @override
  List<Object> get props => [message];
}