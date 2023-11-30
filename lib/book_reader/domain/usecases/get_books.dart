import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class GetBooks extends UseCaseWithOutParams<List<Book>> {
  const GetBooks(this._repository);

  final BookRepository _repository;

  @override
  ResultFuture<List<Book>> call() async => _repository.getBooks();
}
