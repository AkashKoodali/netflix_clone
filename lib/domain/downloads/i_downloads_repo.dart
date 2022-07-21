import 'package:dartz/dartz.dart';
import 'package:netflix_bro/domain/core/failures/main_failure.dart';
import 'package:netflix_bro/domain/downloads/models/downloads.dart';

abstract class IDownloadsRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
