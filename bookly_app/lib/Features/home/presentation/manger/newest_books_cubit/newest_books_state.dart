part of 'newest_books_cubit.dart';

abstract class NewestBooksState extends Equatable {
  const NewestBooksState();

  @override
  List<Object> get props => [];
}

final class NewestBooksInitial extends NewestBooksState {}

class NewsetBooksLoading extends NewestBooksState {}

class NewsetBooksFailure extends NewestBooksState {
  final String errMessage;

  const NewsetBooksFailure(this.errMessage);
}

class NewsetBooksSuccess extends NewestBooksState {
  final List<BookModel> books;

  const NewsetBooksSuccess(this.books);
}
