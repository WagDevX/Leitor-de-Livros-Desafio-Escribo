import 'package:ebook_reader/book_reader/domain/repositories/books_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class RemoveBook extends UseCaseWithParams<void, String> {
  RemoveBook(this._repository);

  final BooksRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.removeBook(key: params);
}
