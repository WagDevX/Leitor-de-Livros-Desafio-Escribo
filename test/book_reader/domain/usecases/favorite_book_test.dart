import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mock.dart';

void main() {
  late BookRepository repository;
  late FavoriteBook usecase;

  setUp(() {
    repository = MockBookRepository();
    usecase = FavoriteBook(repository);
  });

  const testBook = Book.empty();

  test('should successfuly call [BookRepository.favoriteBook]', () async {
    when(() => repository.favoriteBook(id: any(named: 'id')))
        .thenAnswer((_) async => const Right(null));

    final response = await usecase(testBook.id);

    expect(response, equals(const Right<dynamic, void>(null)));
    verify(() => repository.favoriteBook(id: testBook.id)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
