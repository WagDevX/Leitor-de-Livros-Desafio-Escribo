import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class CacheBook extends UseCaseWithParams<void, Book> {
  CacheBook(this._repository);

  final BookRepository _repository;

  @override
  ResultFuture<void> call(Book params) async =>
      _repository.cacheBook(book: params);
}
