import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class RemoveBook extends UseCaseWithParams<void, String> {
  RemoveBook(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.removeBook(id: params);
}