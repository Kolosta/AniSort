import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/anime_model.dart';
import '../../../domain/entities/anime_entity.dart';
import '../../../domain/usecases/get_anime_list_from_api_usecase.dart';
import '../../../domain/usecases/import_anime_list_usecase.dart';
import '../../../domain/usecases/get_local_anime_list_usecase.dart';
import '../../../domain/usecases/upload_anime_list_to_firebase_usecase.dart';
import '../../../domain/usecases/validate_anime_order_usecase.dart';

part 'anime_list_event.dart';
part 'anime_list_state.dart';

class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  final ImportAnimeListUseCase _importAnimeListFromAPI;
  final GetLocalAnimeListUseCase _getLocalAnimeList;
  final GetAnimeListFromApiUseCase _getAnimeListFromApi;
  final UploadAnimeListToFirebaseUseCase _uploadAnimeListToFirebase;
  final ValidateAnimeOrderUseCase _validateAnimeOrder;
  // final UpdateAnimeListUseCase _updateAnimeList;


  // final RefreshAnimeListUseCase _refreshAnimeList;
  // final ExportAnimeListUseCase _exportAnimeList;
  // final ImportAnimeListUseCase _importAnimeList;

  AnimeListBloc(
    this._importAnimeListFromAPI,
    this._getLocalAnimeList,
    this._getAnimeListFromApi,
    this._uploadAnimeListToFirebase,
    this._validateAnimeOrder,
    // this._updateAnimeList,
      // this._refreshAnimeList,
    // this._exportAnimeList,
    // this._importAnimeList,
  ) : super(AnimeListInitialState()) {
    on<ImportAnimeListFromAPIEvent>(_importAnimeListFromAPIHandler);
    on<GetLocalAnimeListEvent>(_getLocalAnimeListHandler);
    on<GetAnimeListFromApiEvent>(_getAnimeListFromApiHandler);
    on<UploadAnimeListToFirebaseEvent>(_uploadAnimeListToFirebaseHandler);
    on<UpdateAnimeListEvent>(_updateAnimeListHandler);
    on<ValidateAnimeOrderEvent>(_validateAnimeOrderHandler);
    // on<RefreshAnimeListEvent>(_refreshAnimeListHandler);
    // on<ExportAnimeListEvent>(_exportAnimeListHandler);
    // on<ImportAnimeListEvent>(_importAnimeListHandler);
  }

  Future<void> _importAnimeListFromAPIHandler(ImportAnimeListFromAPIEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoadingState());

    final result = await _importAnimeListFromAPI.call(ImportParams(username: event.username, type: event.type, status: event.status));

    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())), // Assuming `toString()` provides a meaningful message
          (animeList) => emit(AnimeListSuccessState(animeList)),
    );
  }

  Future<void> _getLocalAnimeListHandler(GetLocalAnimeListEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoadingState());

    final result = await _getLocalAnimeList.call(NoParams());

    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())),
          (animeList) => emit(AnimeListSuccessState(animeList)),
    );
  }

  Future<void> _getAnimeListFromApiHandler(GetAnimeListFromApiEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoadingState());

    final result = await _getAnimeListFromApi.call(GetApiParams(username: event.username, type: event.type, status: event.status));

    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())),
          (animeList) => emit(AnimeListSuccessState(animeList)),
    );
  }

  Future<void> _uploadAnimeListToFirebaseHandler(UploadAnimeListToFirebaseEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoadingState());

    final result = await _uploadAnimeListToFirebase.call(NoParams());

    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())),
          (_) => emit(AnimeListUploadSuccessState()),
    );
  }

  Future<void> _updateAnimeListHandler(UpdateAnimeListEvent event, Emitter<AnimeListState> emit) async {
    emit(AnimeListSuccessState(event.updatedList));
  }

  Future<void> _validateAnimeOrderHandler(ValidateAnimeOrderEvent event, Emitter<AnimeListState> emit) async {
    final result = await _validateAnimeOrder.call(event.animeList.map((anime) => anime.toEntity()).toList());
    result.fold(
          (failure) => emit(AnimeListFailureState(failure.toString())),
          (_) => emit(AnimeListSuccessState(event.animeList.map((anime) => anime.toEntity()).toList())),
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