import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_local_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'book_repository_mocks.dart';

void main() {
  late LocalBookRepository repository;
  late GetLocalBooks usecase;

  setUp(() {
    repository = MockLocalBookRepository();
    usecase = GetLocalBooks(repository);
  });

  final testResponse = [HiveBookModel.criar()];

  test('should call [LocalBookRepository] and return a list of [Book]',
      () async {
    when(() => repository.getBooks())
        .thenAnswer((_) async => Right(testResponse));

    final response = await usecase();

    expect(response, equals(Right<dynamic, List<HiveBookModel>>(testResponse)));
    verify(() => repository.getBooks()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
