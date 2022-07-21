

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bro/domain/core/failures/main_failure.dart';

import 'package:netflix_bro/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_bro/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService homeService;
  HomeBloc(
    this.homeService,
  ) : super(HomeState.initial()) {
    //on event get home screen data
    on<GetHomeScreenData>((event, emit) async {
      log('GETTING HOME SCREEN DATA');
      //send loading to ui
      emit(
        state.copyWith(isLoading: true, hasError: false),
      );

      //get data

      final _movieResult = await homeService.getHotAndNewMovieData();
      final _tvResult = await homeService.getHotAndNewTvData();

      //transfer data

      final _state1 = _movieResult.fold((MainFailure l) {
        return  HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          trendsDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp r) {
        final pastYear = r.results;
        final trending = r.results;
        final dramas = r.results;
        final southIndian = r.results;
        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          trendsDramaMovieList: dramas,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });

      emit(_state1);

      final _state2 = _tvResult.fold((MainFailure l) {
        return  HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          trendsDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp r) {
        final top10List = r.results;
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: top10List,
          trendsDramaMovieList: state.trendsDramaMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: top10List,
          isLoading: false,
          hasError: false,
        );
      });
      //send to ui
      emit(_state2);  

    });
  }
}
