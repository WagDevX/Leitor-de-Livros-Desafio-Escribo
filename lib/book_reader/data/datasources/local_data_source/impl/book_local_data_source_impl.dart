import 'dart:io';

import 'package:ebook_reader/book_reader/data/datasources/local_data_source/book_local_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:ebook_reader/core/utils/typedef.dart';
import 'package:hive/hive.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl(this._favoriteBooksBox, this._booksBox);

  final Box _favoriteBooksBox;
  final Box _booksBox;

  @override
  Future<void> favoriteBook({required int id}) async {
    try {
      if (_favoriteBooksBox.containsKey(id)) {
        _favoriteBooksBox.delete(id);
      }
      _favoriteBooksBox.put(id, true);
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      if (!_booksBox.containsKey(booksHiveBoxName)) {
        throw const CacheExpection(message: 'Nenhum livro encontrado');
      }
      return List<DataMap>.from(_booksBox.values as List)
          .map((bookData) => BookModel.fromMap(bookData))
          .toList();
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }

  @override
  Future<void> removeBook({required int key}) async {
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
      if (_booksBox.values.isEmpty) {
        throw const CacheExpection(message: 'Nenhum livro encontrado');
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
  Future<void> cacheBook({required Book book}) async {
    try {
      if (!_booksBox.isOpen) {
        throw const CacheExpection(message: 'Erro ao salvar Livro');
      }
      _booksBox.add(book);
    } on CacheExpection {
      rethrow;
    } catch (e) {
      throw CacheExpection(message: e.toString());
    }
  }
}

Future<void> _cacheBookFile(String path, File file) async {}
