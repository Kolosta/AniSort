import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/anime_entity.dart';
import '../../../domain/usecases/get_anime_list_usecase.dart';
import '../../../domain/usecases/refresh_anime_list_usecase.dart';


part 'anime_list_event.dart';
part 'anime_list_state.dart';

class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  final GetAnimeListUseCase _getAnimeList;
  // final RefreshAnimeListUseCase _refreshAnimeList;
  // final ExportAnimeListUseCase _exportAnimeList;
  // final ImportAnimeListUseCase _importAnimeList;

  AnimeListBloc(
    this._getAnimeList,
    // this._refreshAnimeList,
    // this._exportAnimeList,
    // this._importAnimeList,
  ) : super(AnimeListInitialState()) {
    on<GetAnimeListEvent>(_getAnimeListHandler);
    // on<RefreshAnimeListEvent>(_refreshAnimeListHandler);
    // on<ExportAnimeListEvent>(_exportAnimeListHandler);
    // on<ImportAnimeListEvent>(_importAnimeListHandler);
  }

  Future<void> _getAnimeListHandler(GetAnimeListEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoadingState());

    final result = await _getAnimeList.call(Params(username: event.username, type: event.type, status: event.status));

    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())), // Assuming `toString()` provides a meaningful message
          (animeList) => emit(AnimeListSuccessState(animeList)),
    );
  }

  // Future<void> _refreshAnimeListHandler(
  //     RefreshAnimeListEvent event, Emitter<AnimeListState> emit) async {
  //   emit(AnimeListLoadingState());
  //   final result = await _refreshAnimeList.call(NoParams());
  //   result.fold(
  //     (failure) => emit(AnimeListFailureState(failure.message)),
  //     (animeList) => emit(AnimeListSuccessState(animeList)),
  //   );
  // }
  //
  // Future<void> _exportAnimeListHandler(
  //     ExportAnimeListEvent event, Emitter<AnimeListState> emit) async {
  //   emit(AnimeListLoadingState());
  //   final result = await _exportAnimeList.call(NoParams());
  //   result.fold(
  //     (failure) => emit(AnimeListFailureState(failure.message)),
  //     (success) => emit(AnimeListExportSuccessState()),
  //   );
  // }
  //
  // Future<void> _importAnimeListHandler(
  //     ImportAnimeListEvent event, Emitter<AnimeListState> emit) async {
  //   emit(AnimeListLoadingState());
  //   final result = await _importAnimeList.call(NoParams());
  //   result.fold(
  //     (failure) => emit(AnimeListFailureState(failure.message)),
  //     (animeList) => emit(AnimeListSuccessState(animeList)),
  //   );
  // }
}