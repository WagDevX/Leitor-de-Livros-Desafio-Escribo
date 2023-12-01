import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class RemoveBook extends UseCaseWithParams<void, int> {
  RemoveBook(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<void> call(int params) async =>
      _repository.removeBook(id: params);
}
