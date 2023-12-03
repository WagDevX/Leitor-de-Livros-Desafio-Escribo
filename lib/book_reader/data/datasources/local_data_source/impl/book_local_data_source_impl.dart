import 'dart:io';

import 'package:ebook_reader/book_reader/data/datasources/local_data_source/book_local_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/typedef.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl(
      {required Box<bool> favoriteBooksBox,
      required Box<HiveBookModel> booksBox})
      : _favoriteBooksBox = favoriteBooksBox,
        _booksBox = booksBox;

  final Box<bool> _favoriteBooksBox;
  final Box<HiveBookModel> _booksBox;

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
  Future<List<HiveBookModel>> getBooks() async {
    try {
      if (_booksBox.values.isEmpty) {
        throw const CacheExpection(message: 'Nenhum livro encontrado');
      }
      return _booksBox.values.cast<HiveBookModel>().toList();
    } on CacheExpection {
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
      final filePath = await _cacheBookFiles(
          bookUrl: book.downloadUrl,
          coverUrl: book.coverUrl,
          title: book.title);

      final newBookModel = bookModel.copyWith(
          downloadUrl: filePath["bookPath"], coverUrl: filePath["coverPath"]);
      final HiveBookModel hiveBookModel = HiveBookModel.criar();
      hiveBookModel.id = book.id;
      hiveBookModel.author = newBookModel.author;
      hiveBookModel.coverUrl = newBookModel.coverUrl;
      hiveBookModel.downloadUrl = newBookModel.downloadUrl;
      hiveBookModel.title = newBookModel.title;
      hiveBookModel.favorite = newBookModel.favorite;
      _booksBox.put(book.id, hiveBookModel);

      return newBookModel;
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }
}

Future<DataMap> _cacheBookFiles(
    {required String bookUrl,
    required String coverUrl,
    required String title}) async {
  Dio dio = Dio();
  Directory? appDocDir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  String bookPath = "${appDocDir!.path}/${title.split("").join()}.epub";
  String coverPath = "${appDocDir.path}/${title.split("").join()}.jpg";
  File file = File(bookPath);
  File fileImage = File(coverPath);

  if (!File(bookPath).existsSync()) {
    await file.create();
    await dio.download(bookUrl, bookPath, deleteOnError: true);
  }

  if (!File(coverPath).existsSync()) {
    await fileImage.create();
    await dio.download(coverUrl, coverPath, deleteOnError: true);
  }

  return {
    "bookPath": bookPath,
    "coverPath": coverPath,
  };
}
