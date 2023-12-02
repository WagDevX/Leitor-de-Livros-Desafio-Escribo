import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class DownloadBook extends UseCaseWithParams<void, Book> {
  DownloadBook(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<void> call(Book params) async =>
      _repository.downloadBook(book: params);
}
