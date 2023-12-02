import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/book_remote_data_source.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/remote_book_repository.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/error/failure.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class RemoteBookRemositoryImpl implements RemoteBookRepository {
  const RemoteBookRemositoryImpl(this._remoteDataSource);

  final BookRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Book>> getBooks() async {
    try {
      final result = await _remoteDataSource.getBooks();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
