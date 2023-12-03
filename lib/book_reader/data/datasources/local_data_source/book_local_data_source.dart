import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';

abstract class BookLocalDataSource {
  const BookLocalDataSource();

  Future<List<BookModel>> getFavoriteBooks();

  Future<Book> downloadBook({required BookModel book});

  Future<void> removeBook({required String key});

  Future<void> favoriteBook({required int id});

  Future<List<HiveBookModel>> getBooks();
}
