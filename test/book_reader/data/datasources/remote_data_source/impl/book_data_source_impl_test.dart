import 'dart:convert';

import 'package:ebook_reader/book_reader/data/datasources/data_source/book_data_source.dart';
import 'package:ebook_reader/book_reader/data/datasources/data_source/impl/book_data_source_impl.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

class MockDataSourceImpl extends Mock implements BookDataSourceImpl {}

class MockFavoritesBox extends Mock implements Box<bool> {}

class MockBooksBox extends Mock implements Box<HiveBookModel> {}

class MockInternetChecker extends Mock implements InternetConnection {}

void main() {
  late http.Client client;
  late BookDataSource bookDataSource;
  late Box<bool> favoritesBox;
  late Box<HiveBookModel> booksBox;
  late InternetConnection internetChecker;

  setUp(() {
    client = MockClient();
    favoritesBox = MockFavoritesBox();
    booksBox = MockBooksBox();
    internetChecker = MockInternetChecker();
    bookDataSource = BookDataSourceImpl(
        client: client,
        favoriteBooksBox: favoritesBox,
        booksBox: booksBox,
        internetChecker: internetChecker);
    registerFallbackValue(Uri());
  });

  group('getBooks', () {
    const tBooks = [BookModel.empty()];
    test('should complete successfuly when the status code is 200', () async {
      when(() => internetChecker.hasInternetAccess)
          .thenAnswer((_) async => true);

      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tBooks.first.toMap()]), 200));

      final response = await bookDataSource.getBooks();

      expect(response, equals(tBooks));
      verify(() => client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint)))
          .called(1);
      verify(() => internetChecker.hasInternetAccess).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      when(() => internetChecker.hasInternetAccess)
          .thenAnswer((_) async => true);

      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Unknown Error', 500));

      final methodCall = bookDataSource.getBooks;

      expect(
          () => methodCall(),
          throwsA(
              const ApiException(message: 'Unknown Error', statusCode: 500)));
      verify(() => internetChecker.hasInternetAccess).called(1);
      // verify(() => client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint)))
      //     .called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
