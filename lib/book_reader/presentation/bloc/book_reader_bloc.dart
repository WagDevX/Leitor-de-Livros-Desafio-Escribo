import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/remove_book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'book_reader_event.dart';
part 'book_reader_state.dart';

class BookReaderBloc extends Bloc<BookReaderEvent, BookReaderState> {
  BookReaderBloc(
      {required DownloadBook download,
      required FavoriteBook favoriteBook,
      required GetBooks getBooks,
      required GetFavoriteBooks getFavoriteBooks,
      required RemoveBook removeBook,
      required Box<HiveBookModel> booksBox})
      : _download = download,
        _favoriteBook = favoriteBook,
        _getBooks = getBooks,
        _getFavoriteBooks = getFavoriteBooks,
        _removeBook = removeBook,
        _booksBox = booksBox,
        super(BookReaderInitial()) {
    on<GetBooksEvent>(_getBooksHandler);
    on<GetFavoriteBooksEvent>(_getFavoriteBooksHandler);
    on<FavoriteBookEvent>(_favoriteBookHandler);
    on<DownlaodBookEvent>(_downlaodBookHandler);
    on<RemoveBookEvent>(_removeBookHandler);
  }

  final DownloadBook _download;
  final FavoriteBook _favoriteBook;
  final GetBooks _getBooks;
  final GetFavoriteBooks _getFavoriteBooks;
  final RemoveBook _removeBook;
  final Box<HiveBookModel> _booksBox;

  Future<void> _getFavoriteBooksHandler(
    GetFavoriteBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _getFavoriteBooks();

    result.fold((failure) => emit(GetFavoriteBooksError(failure.errorMessage)),
        (book) => emit(FavoriteBooksLoaded(book)));
  }

  Future<void> _getBooksHandler(
    GetBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    emit(const BooksLoading());
    final result = await _getBooks();

    result.fold((failure) => emit(GetBooksError(failure.errorMessage)),
        (books) => emit(BooksLoaded(books)));
  }

  Future<void> _favoriteBookHandler(
    FavoriteBookEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _favoriteBook(event.id);

    result.fold((failure) => emit(FavoriteBookError(failure.errorMessage)),
        (_) => emit(const BookFavorited()));
  }

  Future<void> _downlaodBookHandler(
    DownlaodBookEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    bool booksIsDownloaded = _booksBox.get(event.id) == null;
    if (!booksIsDownloaded) {
      emit(const OpeningBook());
    } else {
      emit(const Downloading());
    }
    final result = await _download(Book(
        id: event.id,
        title: event.title,
        author: event.author,
        coverUrl: event.coverUrl,
        downloadUrl: event.downloadUrl,
        favorite: event.favorite));

    result.fold((failure) => emit(DownloadBooksError(failure.errorMessage)),
        (book) {
      if (!booksIsDownloaded) {
        return emit(BookOpenedFromDisk(book));
      } else {
        return emit(Downloaded(book));
      }
    });
  }

  Future<void> _removeBookHandler(
    RemoveBookEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _removeBook(event.key);

    result.fold((failure) => emit(RemoveBookError(failure.errorMessage)),
        (_) => emit(const BookDeleted()));
  }
}
