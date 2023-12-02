import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';

abstract class BookLocalDataSource {
  const BookLocalDataSource();

  Future<List<BookModel>> getFavoriteBooks();

  Future<void> cacheBook({required Book book});

  Future<void> removeBook({required int key});

  Future<void> favoriteBook({required int id});

  Future<List<BookModel>> getBooks();
}
