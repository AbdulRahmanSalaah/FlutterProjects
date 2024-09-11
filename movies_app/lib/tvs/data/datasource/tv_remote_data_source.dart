import 'package:dio/dio.dart';

import '../../../core/data/error/exeptions.dart';
import '../../../core/data/network/error_message_model.dart';
import '../../../core/utils/app_constans.dart';
import '../../domain/usecases/get_season_detail_usecase.dart';
import '../models/season_details_model.dart';
import '../models/tv_show_details_model.dart';
import '../models/tv_show_model.dart';

abstract class BaseTVShowsRemoteDataSource {
  Future<List<TVShowModel>> getOnAirTVShows();
  Future<List<TVShowModel>> getPopularTVShows();
  Future<List<TVShowModel>> getTopRatedTVShows();
  Future<TVShowDetailsModel> getTVShowDetails(int id);
  Future<SeasonDetailsModel> getSeasonDetails(SeasonDetailsParams params);
  Future<List<TVShowModel>> getAllPopularTVShows(int page);
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page);
}

class TVShowsRemoteDataSourceImpl extends BaseTVShowsRemoteDataSource {
  @override
  Future<List<TVShowModel>> getOnAirTVShows() async {
    // final response = await Dio().get(AppConstants.onAirTvShowsPath);
    // if (response.statusCode == 200) {
    //   return List<TVShowModel>.from((response.data['results'] as List)
    //       .map((e) => TVShowModel.fromJson(e)));
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }

    try {
      final response = await Dio().get(
        '${AppConstants.baseUrl}tv/on_the_air?api_key=${AppConstants.apiKey}',
      );
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getPopularTVShows() async {
    // final response = await Dio().get(AppConstants.popularTvShowsPath);
    // if (response.statusCode == 200) {
    //   return List<TVShowModel>.from((response.data['results'] as List)
    //       .map((e) => TVShowModel.fromJson(e)));
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }
    try {
      final response = await Dio().get(
        '${AppConstants.baseUrl}tv/popular?api_key=${AppConstants.apiKey}',
      );
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getTopRatedTVShows() async {
    // final response = await Dio().get(AppConstants.topRatedTvShowsPath);
    // if (response.statusCode == 200) {
    //   return List<TVShowModel>.from((response.data['results'] as List)
    //       .map((e) => TVShowModel.fromJson(e)));
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }

    try{
      final response = await Dio().get(
        '${AppConstants.baseUrl}tv/top_rated?api_key=${AppConstants.apiKey}',
      );
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<TVShowDetailsModel> getTVShowDetails(int id) async {
    // final response = await Dio().get(AppConstants.getTvShowDetailsPath(id));
    // if (response.statusCode == 200) {
    //   return TVShowDetailsModel.fromJson(response.data);
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }
    try{
     final response = await Dio().get(AppConstants.getTvShowDetailsPath(id));
      return TVShowDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<SeasonDetailsModel> getSeasonDetails(
      SeasonDetailsParams params) async {
    // final response = await Dio().get(AppConstants.getSeasonDetailsPath(params));
    // if (response.statusCode == 200) {
    //   return SeasonDetailsModel.fromJson(response.data);
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }
    try{
      final response = await Dio().get(AppConstants.getSeasonDetailsPath(params));
      return SeasonDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getAllPopularTVShows(int page) async {
    try {
      final responses = await Future.wait([
        Dio().get(
            '${AppConstants.baseUrl}tv/popular?api_key=${AppConstants.apiKey}&page= $page'),
        Dio().get(
            '${AppConstants.baseUrl}tv/popular?api_key=${AppConstants.apiKey}&page=2'),
      ]);

      // Process and combine results from both responses
      List<TVShowModel> tvShowsPage1 = List<TVShowModel>.from(
          (responses[0].data['results'] as List)
              .map((e) => TVShowModel.fromJson(e)));

      List<TVShowModel> tvShowsPage2 = List<TVShowModel>.from(
          (responses[1].data['results'] as List)
              .map((e) => TVShowModel.fromJson(e)));

      // Combine tvShows from both pages
      return [...tvShowsPage1, ...tvShowsPage2];
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }

    // Process and combine results from both responses
  }

  @override
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page) async {
    try {
      final response = await Future.wait([
        Dio().get(
            '${AppConstants.baseUrl}tv/top_rated?api_key=${AppConstants.apiKey}&page=$page'),
        Dio().get(
            '${AppConstants.baseUrl}tv/top_rated?api_key=${AppConstants.apiKey}&page=2'),
      ]);

      // Process and combine results from both responses
      List<TVShowModel> tvShowsPage1 = List<TVShowModel>.from(
          (response[0].data['results'] as List)
              .map((e) => TVShowModel.fromJson(e)));

      List<TVShowModel> tvShowsPage2 = List<TVShowModel>.from(
          (response[1].data['results'] as List)
              .map((e) => TVShowModel.fromJson(e)));

      // Combine tvShows from both pages
      return [...tvShowsPage1, ...tvShowsPage2];
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  ErrorMessageModel _handleDioError(DioException dioError) {
    String message = 'An unknown error occurred';

    if (dioError.response != null) {
      // If the server returns an error response
      return ErrorMessageModel.fromJson(dioError.response!.data);
    } else if (dioError.type == DioExceptionType.connectionTimeout) {
      message = 'Connection timed out';
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      message = 'Receive timeout in connection with the server';
    } else if (dioError.type == DioExceptionType.badCertificate) {
      message = 'The connection was not secure';
    } else if (dioError.type == DioExceptionType.connectionError) {
      message = 'Connection to the server failed';
    } else if (dioError.type == DioExceptionType.unknown) {
      message = 'Connection to the server failed due to an unknown error';
    }

    return ErrorMessageModel(
      statusCode: 0,
      statusMessage: message,
      success: false,
    );
  }
}
