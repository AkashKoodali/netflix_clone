import 'package:dartz/dartz.dart';
import 'package:netflix_bro/domain/core/failures/main_failure.dart';
import 'package:netflix_bro/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

abstract class HotAndNewService{
  Future<Either<MainFailure,HotAndNewResp>> getHotAndNewMovieData();
  Future<Either<MainFailure,HotAndNewResp>> getHotAndNewTvData();
}