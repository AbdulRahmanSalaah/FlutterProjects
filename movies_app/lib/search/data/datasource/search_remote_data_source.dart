import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:movies_app/core/data/network/error_message_model.dart';
import 'package:movies_app/core/utils/app_constans.dart';
import 'package:movies_app/search/data/models/search_result_item_model.dart';

import '../../../core/data/error/exeptions.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

abstract class BaseSearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search(String title);
}

class SearchRemoteDataSourceImpl extends BaseSearchRemoteDataSource {
  @override
  Future<List<SearchResultItemModel>> search(
    String title,
  ) async {
    log('SearchRemoteDataSourceImpl search title: $title');
    langdetect.initLangDetect();

    String detectedLanguage = 'en';
    if (title.isNotEmpty) {
      try {
        detectedLanguage = langdetect.detect(title);
      } catch (e) {
        log('Language detection failed, falling back to English: $e');
        detectedLanguage = 'en';
      }
    }

    if (detectedLanguage == 'ur') {
      detectedLanguage = 'ar';
    }
    log('SearchRemoteDataSourceImpl search detectedLanguage: $detectedLanguage');

    try {
      final url = AppConstants.getSearchPath(title, detectedLanguage);
      log('Request URL: $url');

      final response =
          await Dio().get(AppConstants.getSearchPath(title, detectedLanguage));

      // log('SearchRemoteDataSourceImpl search response: $response');

      //  this is the response.data['results'] as List part
      // that we need to change to the SearchResultItemModel
      //  and we need to filter the results to remove the person type
      // and we need to map the results to the SearchResultItemModel
      // and we need to return the List<SearchResultItemModel>
      return List<SearchResultItemModel>.from((response.data['results'] as List)
          .where((e) => e['media_type'] != 'person')
          .map((e) => SearchResultItemModel.fromJson(e)));
    } on DioException catch (e) {
      log('SearchRemoteDataSourceImpl search DioError: $e');
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
