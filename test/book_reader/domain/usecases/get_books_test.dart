import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mock.dart';

void main() {
  late BookRepository repository;
  late GetBooks usecase;

  setUp(() {
    repository = MockBookRepository();
    usecase = GetBooks(repository);
  });

  final testResponse = [const Book.empty()];

  test('should call [BookRepository] and return a list of [Book]', () async {
    when(() => repository.getBooks())
        .thenAnswer((_) async => Right(testResponse));

    final response = await usecase();

    expect(response, equals(Right<dynamic, List<Book>>(testResponse)));
    verify(() => repository.getBooks()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
