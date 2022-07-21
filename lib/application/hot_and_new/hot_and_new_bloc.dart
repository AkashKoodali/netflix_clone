import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bro/domain/core/failures/main_failure.dart';
import 'package:netflix_bro/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_bro/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    //get hot and new movie data
    on<LoadDataInComingSoon>(
      (event, emit) async {
        //sent loading to ui
        emit(const HotAndNewState(
          comingSoonList: [],
          everyOnesWatching: [],
          isLoading: true,
          hasError: false,
        ));

        //get data from remote
        final result = await _hotAndNewService.getHotAndNewMovieData();

        //data to state
        final newState = result.fold(
          (MainFailure l) {
            return const HotAndNewState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResp r) {
            return HotAndNewState(
              comingSoonList: r.results,
              everyOnesWatching: state.everyOnesWatching,
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(newState);
      },
    );

    //hot and new tv data
    on<LoadDataInEveryOnesWatching>((event, emit) async {
      //sent loading to ui
        emit(const HotAndNewState(
          comingSoonList: [],
          everyOnesWatching: [],
          isLoading: true,
          hasError: false,
        ));

        //get data from remote
        final result = await _hotAndNewService.getHotAndNewTvData();

        //data to state
        final newState = result.fold(
          (MainFailure l) {
            return const HotAndNewState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResp r) {
            return HotAndNewState(
              comingSoonList: state.comingSoonList,
              everyOnesWatching: r.results,
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(newState);
    });
  }
}
