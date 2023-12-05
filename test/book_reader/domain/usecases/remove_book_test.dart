import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/books_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/remove_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mocks.dart';

void main() {
  late BooksRepository repository;
  late RemoveBook usecase;

  const testBook = Book.empty();

  setUp(() {
    repository = MockBookRepository();
    usecase = RemoveBook(repository);
    registerFallbackValue(testBook);
  });

  test('should successfuly call [LocalBookRepository.removeBook]', () async {
    when(() => repository.removeBook(key: any(named: 'key')))
        .thenAnswer((_) async => const Right(null));

    final response = await usecase(testBook.id.toString());

    expect(response, equals(const Right<dynamic, void>(null)));
    verify(() => repository.removeBook(key: testBook.id.toString())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
