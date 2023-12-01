import 'dart:convert';
import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/impl/book_remote_data_source_impl.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/core/error/exceptions.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late BookRemoteDataSourceImpl remoteBookDataSource;

  setUp(() {
    client = MockClient();
    remoteBookDataSource = BookRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('getBooks', () {
    const tBooks = [BookModel.empty()];
    test('should complete successfuly when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tBooks.first.toMap()]), 200));

      final response = await remoteBookDataSource.getBooks();

      expect(response, equals(tBooks));
      verify(() => client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint)));
      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Unknown Error', 500));

      final methodCall = remoteBookDataSource.getBooks;

      expect(
          () => methodCall(),
          throwsA(
              const ApiException(message: 'Unknown Error', statusCode: 500)));
      verify(() => client.get(Uri.https(apiBooksBaseUrl, apiBooksEndpoint)));
      verifyNoMoreInteractions(client);
    });
  });
}
