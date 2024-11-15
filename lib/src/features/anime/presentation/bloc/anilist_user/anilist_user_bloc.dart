import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/failure_converter.dart';
import '../../../domain/entities/anilist_user_entity.dart';
import '../../../domain/usecases/get_anilist_user_usecase.dart';

part 'anilist_user_event.dart';
part 'anilist_user_state.dart';

class AnilistUserBloc extends Bloc<AnilistUserEvent, AnilistUserState> {
  final GetAnilistUserUseCase _getUser;

  AnilistUserBloc(this._getUser) : super(AnilistUserInitialState()) {
    on<GetAnilistUserEvent>(_getUserInfo);
  }

  Future<void> _getUserInfo(GetAnilistUserEvent event, Emitter<AnilistUserState> emit) async {
    emit(AnilistUserLoadingState());

    final result = await _getUser.call(Params(username: event.username));

    result.fold(
      (failure) => emit(AnilistUserFailureState(mapFailureToMessage(failure))),
      (user) => emit(AnilistUserSuccessState(user)),
    );
  }
}