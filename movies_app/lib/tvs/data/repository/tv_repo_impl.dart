import 'package:dartz/dartz.dart';
import 'package:movies_app/tvs/domain/entities/season_details.dart';
import 'package:movies_app/tvs/domain/repository/base_tv_repo.dart';
import 'package:movies_app/tvs/domain/usecases/get_season_detail_usecase.dart';

import '../../../core/data/error/exeptions.dart';
import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/entities/media_details.dart';
import '../datasource/tv_remote_data_source.dart';

class TVShowsRepositoryImpl extends BaseTvRepo {
  final BaseTVShowsRemoteDataSource baseTVShowsRemoteDataSource;

  TVShowsRepositoryImpl(this.baseTVShowsRemoteDataSource);

  @override
  Future<Either<Failure, List<Media>>> getNowPlayingTv() async {
    try {
      final result = await baseTVShowsRemoteDataSource.getOnAirTVShows();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getPopularTv() async {
    try {
      final result = await baseTVShowsRemoteDataSource.getPopularTVShows();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getTopRatedTv() async {
    try {
      final result = await baseTVShowsRemoteDataSource.getTopRatedTVShows();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MediaDetails>> getTVShowDetails(int id) async {
    try {
      final result = await baseTVShowsRemoteDataSource.getTVShowDetails(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, SeasonDetails>> getSeasonDetails(
      SeasonDetailsParams params) async {
    try {
      final result = await baseTVShowsRemoteDataSource.getSeasonDetails(params);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllPopularTVShows(int page) async {
    try {
      final result =
          await baseTVShowsRemoteDataSource.getAllPopularTVShows(page);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllTopRatedTVShows(int page) async {
    try {
      final result =
          await baseTVShowsRemoteDataSource.getAllTopRatedTVShows(page);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }
}
