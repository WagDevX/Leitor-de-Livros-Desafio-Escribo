import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/data/datasources/data_source/book_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/books_repository.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/error/failure.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class BooksRepositoryImpl implements BooksRepository {
  const BooksRepositoryImpl(this._dataSource);

  final BookDataSource _dataSource;

  @override
  ResultFuture<Book> downloadBook({required Book book}) async {
    try {
      final result = await _dataSource.downloadBook(
          book: BookModel(
              id: book.id,
              title: book.title,
              author: book.author,
              coverUrl: book.coverUrl,
              downloadUrl: book.downloadUrl));
      return Right(result);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> favoriteBook({required int id}) async {
    try {
      await _dataSource.favoriteBook(id: id);
      return const Right(null);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Book>> getBooks() async {
    try {
      final response = await _dataSource.getBooks();
      return Right(response);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Book>> getFavoriteBooks() async {
    try {
      final response = await _dataSource.getFavoriteBooks();
      return Right(response);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> removeBook({required String key}) async {
    try {
      await _dataSource.removeBook(key: key);
      return const Right(null);
    } on CacheExpection catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
