import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/data/datasources/local_data_source/book_local_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/error/failure.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class LocalBookRepositoryImpl implements LocalBookRepository {
  const LocalBookRepositoryImpl(this._localDataSource);

  final BookLocalDataSource _localDataSource;

  @override
  ResultFuture<void> downloadBook({required Book book}) async {
    try {
      await _localDataSource.downloadBook(
          book: BookModel(
              id: book.id,
              title: book.title,
              author: book.author,
              coverUrl: book.coverUrl,
              downloadUrl: book.downloadUrl));
      return const Right(null);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> favoriteBook({required int id}) async {
    try {
      await _localDataSource.favoriteBook(id: id);
      return const Right(null);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Book>> getBooks() async {
    try {
      final response = await _localDataSource.getBooks();
      return Right(response);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Book>> getFavoriteBooks() async {
    try {
      final response = await _localDataSource.getFavoriteBooks();
      return Right(response);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> removeBook({required String key}) async {
    try {
      await _localDataSource.removeBook(key: key);
      return const Right(null);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
