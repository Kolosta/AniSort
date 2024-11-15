part of 'anilist_user_bloc.dart';


abstract class AnilistUserEvent extends Equatable {
  const AnilistUserEvent();

  @override
  List<Object> get props => [];
}

class GetAnilistUserEvent extends AnilistUserEvent {
  final String username;

  const GetAnilistUserEvent(this.username);

  @override
  List<Object> get props => [username];
}