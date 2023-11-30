import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/cache_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mock.dart';

void main() {
  late BookRepository repository;
  late CacheBook usecase;

  const testBook = Book.empty();

  setUp(() {
    repository = MockBookRepository();
    usecase = CacheBook(repository);
    registerFallbackValue(testBook);
  });

  test('should successfuly call [BookRepository.cacheBook]', () async {
    when(() => repository.cacheBook(book: any(named: 'book')))
        .thenAnswer((_) async => const Right(null));

    final response = await usecase(testBook);

    expect(response, equals(const Right<dynamic, void>(null)));
    verify(() => repository.cacheBook(book: testBook)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
