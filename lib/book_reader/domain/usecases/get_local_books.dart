import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class GetLocalBooks extends UseCaseWithOutParams<List<Book>> {
  const GetLocalBooks(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<List<Book>> call() async => _repository.getBooks();
}
