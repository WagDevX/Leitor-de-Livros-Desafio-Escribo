import 'package:ebook_reader/book_reader/data/models/book_model.dart';

abstract class BookLocalDataSource {
  const BookLocalDataSource();

  Future<List<BookModel>> getFavoriteBooks();

  Future<void> downloadBook({required BookModel book});

  Future<void> removeBook({required String key});

  Future<void> favoriteBook({required int id});

  Future<List<BookModel>> getBooks();
}
