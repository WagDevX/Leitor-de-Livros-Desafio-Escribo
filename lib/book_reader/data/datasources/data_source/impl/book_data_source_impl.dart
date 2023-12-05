import 'dart:convert';
import 'dart:io';

import 'package:ebook_reader/book_reader/data/datasources/data_source/book_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:ebook_reader/core/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:http/http.dart' as http;

class BookDataSourceImpl implements BookDataSource {
  BookDataSourceImpl({
    required Box<bool> favoriteBooksBox,
    required Box<HiveBookModel> booksBox,
    required InternetConnection internetChecker,
    required http.Client client,
  })  : _favoriteBooksBox = favoriteBooksBox,
        _booksBox = booksBox,
        _internetChecker = internetChecker,
        _client = client;

  final Box<bool> _favoriteBooksBox;
  final Box<HiveBookModel> _booksBox;
  final http.Client _client;
  final InternetConnection _internetChecker;

  @override
  Future<void> favoriteBook({required int id}) async {
    try {
      if (_favoriteBooksBox.get(id) != null) {
        await _favoriteBooksBox.delete(id);
      } else if (_favoriteBooksBox.get(id) == null) {
        await _favoriteBooksBox.put(id, true);
      }
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<List<Book>> getBooks() async {
    try {
      bool hasInternet = await _internetChecker.hasInternetAccess;
      if (hasInternet) {
        final response =
            await _client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint));
        if (response.statusCode != 200) {
          throw ApiException(
              message: response.body, statusCode: response.statusCode);
        }
        return List<DataMap>.from(jsonDecode(response.body) as List)
            .map((bookData) => BookModel.fromMap(bookData))
            .toSet()
            .toList();
      } else {
        if (_booksBox.values.isEmpty) {
          throw const CacheExpection(message: 'Nenhum livro baixado ainda');
        }
        return _booksBox.values
            .map((hiveBook) => BookModel.fromHiveModel(hiveBook))
            .toList();
      }
    } on CacheExpection {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<void> removeBook({required String key}) async {
    try {
      if (!_booksBox.containsKey(key)) {
        throw const CacheExpection(
            message: 'Erro ao deletar: Livro não encontrado');
      }
      _booksBox.delete(key);
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    final favorites = _favoriteBooksBox.keys;
    try {
      if (favorites.isEmpty) {
        throw const CacheExpection(message: 'Nenhum livro favoritado!');
      }
      if (_booksBox.isEmpty) {
        throw const CacheExpection(message: 'Nenhum livro favoritado!');
      }
      return List<DataMap>.from(_booksBox.values as List)
          .map((bookData) => BookModel.fromMap(bookData))
          .toList()
          .where((element) => favorites.contains(element.id))
          .toList();
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<Book> downloadBook({required Book book}) async {
    final BookModel bookModel = BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        downloadUrl: book.downloadUrl);
    try {
      if (!_booksBox.isOpen) {
        throw const CacheExpection(message: 'Erro ao salvar Livro');
      }
      Dio dio = Dio();
      Directory? appDocDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String bookPath =
          "${appDocDir!.path}/${book.title.split("").join()}.epub";
      String coverPath = "${appDocDir.path}/${book.title.split("").join()}.jpg";
      File file = File(bookPath);
      File fileImage = File(coverPath);

      if (!File(bookPath).existsSync()) {
        await file.create();
        final bookResponse =
            await dio.download(book.downloadUrl, bookPath, deleteOnError: true);
        if (bookResponse.statusCode != 200) {
          throw ApiException(
              message: bookResponse.statusMessage.toString(),
              statusCode: bookResponse.statusCode?.toInt() ?? 500);
        }
      }

      if (!File(coverPath).existsSync()) {
        await fileImage.create();
        final coverResponse =
            await dio.download(book.coverUrl, coverPath, deleteOnError: true);
        if (coverResponse.statusCode != 200) {
          throw ApiException(
              message: coverResponse.statusMessage.toString(),
              statusCode: coverResponse.statusCode?.toInt() ?? 500);
        }
      }

      if (await file.length() == 0 || await fileImage.length() == 0) {
        await fileImage.delete();
        await file.delete();
        throw (const CacheExpection(message: "Erro ao salvar arquivo"));
      } else {
        final newBookModel =
            bookModel.copyWith(downloadUrl: bookPath, coverUrl: coverPath);
        final HiveBookModel hiveBookModel = HiveBookModel.criar();
        hiveBookModel.id = book.id;
        hiveBookModel.author = newBookModel.author;
        hiveBookModel.coverUrl = newBookModel.coverUrl;
        hiveBookModel.downloadUrl = newBookModel.downloadUrl;
        hiveBookModel.title = newBookModel.title;
        hiveBookModel.favorite = newBookModel.favorite;
        _booksBox.put(book.id, hiveBookModel);
        return newBookModel;
      }
    } on CacheExpection {
      rethrow;
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheExpection(message: e.toString());
    }
  }
}
