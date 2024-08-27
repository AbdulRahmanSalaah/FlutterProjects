import 'package:bookly_app/core/errors/failures.dart';

import 'package:bookly_app/core/models/book_model/book_model.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_service.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  SearchRepoImpl(this.apiService);
  final ApiService apiService;

  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBook(
      {required String query}) async {
    try {
      var data = await apiService.get(
        endPoint: 'volumes?q=$query',
      );
      List<BookModel> books = [];
      if (data['items'] != null) {
        for (var item in data['items']) {
          try {
            books.add(BookModel.fromJson(item));
          } catch (e) {
            books.add(BookModel.fromJson(item));
          }
        }
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
