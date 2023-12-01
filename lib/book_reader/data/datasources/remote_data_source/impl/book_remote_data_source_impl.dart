import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/book_remote_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  const BookRemoteDataSourceImpl(this._remoteDataSource);

  final BookRemoteDataSource _remoteDataSource;

  @override
  Future<void> downloadBook({required String id}) {
    // TODO: implement downloadBook
    throw UnimplementedError();
  }

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
}
