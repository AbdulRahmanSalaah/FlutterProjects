import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';

import '../../../core/data/error/exeptions.dart';
import '../../../core/data/network/error_message_model.dart';
import '../../../core/utils/app_constans.dart';
import '../models/movie_details_model.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> getAllPopularMovies(int page);
  Future<List<MovieModel>> getAllTopRatedMovies(int page);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await Dio().get(
        '${AppConstants.baseUrl}movie/now_playing?api_key=${AppConstants.apiKey}',
      );
      // log('getNowPlayingMovies response: ${response.data}');
      return _processResponse(response);
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await Dio().get(
        '${AppConstants.baseUrl}movie/popular?api_key=${AppConstants.apiKey}',
      );

      // log('getPopularMovies response: ${response.data}');
      return _processResponse(response);
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await Dio().get(
        '${AppConstants.baseUrl}movie/top_rated?api_key=${AppConstants.apiKey}',
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      log('url'
          '${AppConstants.baseUrl}movie/$movieId?api_key=${AppConstants.apiKey}&append_to_response=videos,credits,reviews,similar');
      final response = await Dio().get(
        '${AppConstants.baseUrl}movie/$movieId?api_key=${AppConstants.apiKey}&append_to_response=videos,credits,reviews,similar',
      );
      if (response.statusCode == 200) {
        return MovieDetailsModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<MovieModel>> getAllPopularMovies(int page) async {
    try {
      final responses = await Future.wait([
        Dio().get(
            '${AppConstants.baseUrl}movie/popular?api_key=${AppConstants.apiKey}&page= $page'),
        Dio().get(
            '${AppConstants.baseUrl}movie/popular?api_key=${AppConstants.apiKey}&page=2'),
      ]);

      // Process and combine results from both responses
      List<MovieModel> moviesPage1 = _processResponse(responses[0]);
      List<MovieModel> moviesPage2 = _processResponse(responses[1]);

      // Combine movies from both pages
      return [...moviesPage1, ...moviesPage2];
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  @override
  Future<List<MovieModel>> getAllTopRatedMovies(int page) async {
    try {
      final response = await Future.wait([
        Dio().get(
            '${AppConstants.baseUrl}movie/top_rated?api_key=${AppConstants.apiKey}&page=$page'),
        Dio().get(
            '${AppConstants.baseUrl}movie/top_rated?api_key=${AppConstants.apiKey}&page=2'),
      ]);

      // Process and combine results from both responses
      List<MovieModel> moviesPage1 = _processResponse(response[0]);
      List<MovieModel> moviesPage2 = _processResponse(response[1]);

      // Combine movies from both pages

      return [...moviesPage1, ...moviesPage2];
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: _handleDioError(e),
      );
    }
  }

  List<MovieModel> _processResponse(Response response) {
    final List<MovieModel> movies = [];
    if (response.statusCode == 200) {
      final data = response.data['results'] as List;
      for (var movie in data) {
        movies.add(MovieModel.fromJson(movie));
      }
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
    return movies;
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
