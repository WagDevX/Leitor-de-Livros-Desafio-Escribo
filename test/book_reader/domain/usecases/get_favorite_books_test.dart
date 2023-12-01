import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mocks.dart';

void main() {
  late LocalBookRepository repository;
  late GetFavoriteBooks usecase;

  setUp(() {
    repository = MockLocalBookRepository();
    usecase = GetFavoriteBooks(repository);
  });

  final testResponse = [const Book.empty()];

  test('should call [LocalBookRepository] and return a list of favorite [Book]',
      () async {
    when(() => repository.getFavoriteBooks())
        .thenAnswer((_) async => Right(testResponse));

    final response = await usecase();

    expect(response, equals(Right<dynamic, List<Book>>(testResponse)));
    verify(() => repository.getFavoriteBooks()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
