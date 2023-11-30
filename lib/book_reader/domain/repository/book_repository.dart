import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

abstract class BookRepository {
  const BookRepository();

  ResultFuture<List<Book>> getBooks();

  ResultFuture<void> favoriteBook({required String id});

  ResultFuture<void> downloadBook({required String id});

  ResultFuture<void> cacheBook({required Book book});
}
