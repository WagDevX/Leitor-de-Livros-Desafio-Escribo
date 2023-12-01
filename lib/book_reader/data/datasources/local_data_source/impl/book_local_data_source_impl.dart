import 'package:ebook_reader/book_reader/data/datasources/local_data_source/book_local_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl(this._localDataSource);

  final BookLocalDataSource _localDataSource;

  @override
  Future<void> favoriteBook({required String id}) {
    // TODO: implement favoriteBook
    throw UnimplementedError();
  }

  @override
  Future<List<BookModel>> getBooks() {
    // TODO: implement getBooks
    throw UnimplementedError();
  }

  @override
  Future<void> removeBook({required String id}) {
    // TODO: implement removeBook
    throw UnimplementedError();
  }
}
