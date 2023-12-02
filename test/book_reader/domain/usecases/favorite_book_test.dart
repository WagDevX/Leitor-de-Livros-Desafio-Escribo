import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mocks.dart';

void main() {
  late LocalBookRepository repository;
  late FavoriteBook usecase;

  setUp(() {
    repository = MockLocalBookRepository();
    usecase = FavoriteBook(repository);
  });

  const testBook = Book.empty();

  test('should successfuly call [LocalBookRepository.favoriteBook]', () async {
    when(() => repository.favoriteBook(id: any(named: 'id')))
        .thenAnswer((_) async => const Right(null));

    final response = await usecase(testBook.id);

    expect(response, equals(const Right<dynamic, void>(null)));
    verify(() => repository.favoriteBook(id: testBook.id)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
