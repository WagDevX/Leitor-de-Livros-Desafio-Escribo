import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

abstract class RemoteBookRepository {
  const RemoteBookRepository();

  ResultFuture<List<Book>> getBooks();

  ResultFuture<void> favoriteBook({required String id});

  ResultFuture<void> downloadBook({required String id});
}
