import 'dart:convert';

import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/book_remote_data_source.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:ebook_reader/core/utils/typedef.dart';
import 'package:http/http.dart' as http;

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  const BookRemoteDataSourceImpl(this._client);

  final http.Client _client;

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
  Future<List<BookModel>> getBooks() async {
    try {
      final response =
          await _client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint));
      if (response.statusCode != 200) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((bookData) => BookModel.fromMap(bookData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
