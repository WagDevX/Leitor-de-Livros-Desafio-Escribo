import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_local_books.dart';
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
      required GetLocalBooks getLocalBooks,
      required RemoveBook removeBook,
      required Box<HiveBookModel> booksBox})
      : _download = download,
        _favoriteBook = favoriteBook,
        _getBooks = getBooks,
        _getFavoriteBooks = getFavoriteBooks,
        _getLocalBooks = getLocalBooks,
        _removeBook = removeBook,
        _booksBox = booksBox,
        super(BookReaderInitial()) {
    on<GetRemoteBooksEvent>(_getRemoteBooksHandler);
    on<GetLocalBooksEvent>(_getLocalBooksHandler);
    on<GetFavoriteBooksEvent>(_getFavoriteBooksHandler);
    on<FavoriteBookEvent>(_favoriteBookHandler);
    on<DownlaodBookEvent>(_downlaodBookHandler);
    on<RemoveBookEvent>(_removeBookHandler);
  }

  final DownloadBook _download;
  final FavoriteBook _favoriteBook;
  final GetBooks _getBooks;
  final GetFavoriteBooks _getFavoriteBooks;
  final GetLocalBooks _getLocalBooks;
  final RemoveBook _removeBook;
  final Box<HiveBookModel> _booksBox;

  Future<void> _getFavoriteBooksHandler(
    GetFavoriteBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _getFavoriteBooks();

    result.fold((failure) => emit(GetLocalBooksError(failure.errorMessage)),
        (book) => emit(FavoriteBooksLoaded(book)));
  }

  Future<void> _getRemoteBooksHandler(
    GetRemoteBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    emit(const BooksLoading());
    final result = await _getBooks();

    result.fold((failure) => emit(GetRemoteBooksError(failure.errorMessage)),
        (books) => emit(RemoteBooksLoaded(books)));
  }

  Future<void> _getLocalBooksHandler(
    GetLocalBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    emit(const LocalBooksLoading());
    final result = await _getLocalBooks();

    result.fold((failure) => emit(GetLocalBooksError(failure.errorMessage)),
        (books) => emit(LocalBooksLoaded(books)));
  }

  Future<void> _favoriteBookHandler(
    FavoriteBookEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _favoriteBook(event.id);

    result.fold((failure) => emit(FavorieBookError(failure.errorMessage)),
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

    result.fold((failure) => emit(DownloadBooksError(failure.errorMessage)),
        (_) => emit(const BookDeleted()));
  }
}
