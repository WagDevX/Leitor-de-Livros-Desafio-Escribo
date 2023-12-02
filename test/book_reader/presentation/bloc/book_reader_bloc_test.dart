import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_local_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/remove_book.dart';
import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBooks extends Mock implements GetBooks {}

class MockGetLocalBooks extends Mock implements GetLocalBooks {}

class MockRemoveBook extends Mock implements RemoveBook {}

class MockDownloadBook extends Mock implements DownloadBook {}

class MockGetFavoriteBooks extends Mock implements GetFavoriteBooks {}

class MockFavoriteBook extends Mock implements FavoriteBook {}

void main() {
  late GetBooks getBooks;
  late GetLocalBooks getLocalBooks;
  late GetFavoriteBooks getFavoriteBooks;
  late RemoveBook removeBook;
  late DownloadBook downloadBooks;
  late FavoriteBook favoriteBook;
  late BookReaderBloc bookBloc;

  setUp(() {
    getLocalBooks = MockGetLocalBooks();
    getBooks = MockGetBooks();
    removeBook = MockRemoveBook();
    downloadBooks = MockDownloadBook();
    favoriteBook = MockFavoriteBook();
    getFavoriteBooks = MockGetFavoriteBooks();
    bookBloc = BookReaderBloc(
        download: downloadBooks,
        favoriteBook: favoriteBook,
        getBooks: getBooks,
        getFavoriteBooks: getFavoriteBooks,
        getLocalBooks: getLocalBooks,
        removeBook: removeBook);
  });

  tearDown(() => bookBloc.close());

  test('initialState should be [AuthInitial]', () {
    expect(bookBloc.state, BookReaderInitial());
  });

  group('SignInEvent', () {
    const list = [Book.empty()];
    blocTest<BookReaderBloc, BookReaderState>(
        'should emit  [AuthLoading, SignedIn] '
        'when [SignInEvent] is addead',
        build: () {
          when(() => getBooks()).thenAnswer((_) async => const Right(list));
          return bookBloc;
        },
        act: (bloc) => bloc.add(const GetRemoteBooksEvent()),
        expect: () => const [BooksLoading(), RemoteBooksLoaded(list)]);
  });
}
