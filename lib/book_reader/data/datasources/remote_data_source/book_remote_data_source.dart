import 'package:ebook_reader/book_reader/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  const BookRemoteDataSource();

  Future<List<BookModel>> getBooks();
}
