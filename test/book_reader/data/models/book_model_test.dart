import 'dart:convert';

import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/core/utils/typedef.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tBookModel = BookModel.empty();
  test(
    'should be a subclass of [BookModel] entity',
    () => expect(
      tBookModel,
      isA<BookModel>(),
    ),
  );
  final tMap = jsonDecode(fixture('book.json')) as DataMap;

  group('fromMap', () {
    test('should return a valid [BookModel]', () {
      // act
      final result = BookModel.fromMap(tMap);

      //Assert
      expect(result, isA<BookModel>());
      expect(result, tBookModel);
    });
    test('should thrown an [Error] when the map is invalid', () {
      final map = DataMap.from(tMap)..remove('id');

      const call = BookModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the [BookModel]', () {
      final result = tBookModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a [BookModel] with updated values', () {
      final result = tBookModel.copyWith(id: 2);
      expect(result.id, 2);
    });
  });
}
