import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/books_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mocks.dart';

void main() {
  late BooksRepository repository;
  late DownloadBook usecase;

  const testBook = Book.empty();

  setUp(() {
    repository = MockBookRepository();
    usecase = DownloadBook(repository);
    registerFallbackValue(testBook);
  });

  test(
      'should successfuly call [LocalBookRepository.downloadBook] and return downloaded book',
      () async {
    when(() => repository.downloadBook(book: any(named: 'book')))
        .thenAnswer((_) async => const Right(testBook));

    final response = await usecase(testBook);

    expect(response, equals(const Right<dynamic, Book>(testBook)));
    verify(() => repository.downloadBook(book: testBook)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
