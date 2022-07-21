import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bro/domain/core/failures/main_failure.dart';
import 'package:netflix_bro/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_bro/domain/search/model/search_service.dart';

import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/model/search_repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadServiece;
  final SearchService _searchService;
  SearchBloc(this._downloadServiece, this._searchService)
      : super(SearchState.initial()) {
    /*
    idle state
    */
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending
      final result = await _downloadServiece.getDownloadsImages();
      final stat = result.fold((MainFailure f) {
        emit(const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: true,
        ));
      }, (List<Downloads> list) {
        emit(SearchState(
          searchResultList: [],
          idleList: list,
          isLoading: false,
          isError: false,
        ));
      });
      //show to ui
      emit(stat);
    });
/*
    search result state
  */
    on<SearchMovie>((event, emit) async {
      log('Searchig for ${event.movieQuery}');
      //call search movie api
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold((MainFailure l) {
        emit(const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: true,
        ));
      }, (SearchRepo r) {
        emit(SearchState(
          searchResultList: r.results,
          idleList: [],
          isLoading: false,
          isError: false,
        ));
      });
      //show tp ui
      emit(_state);
    });
  }
}
