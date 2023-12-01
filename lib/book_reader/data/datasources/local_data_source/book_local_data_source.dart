import 'package:ebook_reader/book_reader/data/models/book_model.dart';

abstract class BookLocalDataSource {
  const BookLocalDataSource();

  Future<void> removeBook({required String id});

  Future<void> favoriteBook({required String id});

  Future<List<BookModel>> getBooks();
}
