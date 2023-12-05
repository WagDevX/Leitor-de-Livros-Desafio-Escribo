import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

abstract class BooksRepository {
  const BooksRepository();

  ResultFuture<List<Book>> getBooks();

  ResultFuture<List<Book>> getFavoriteBooks();

  ResultFuture<void> favoriteBook({required int id});

  ResultFuture<void> removeBook({required String key});

  ResultFuture<Book> downloadBook({required Book book});
}
