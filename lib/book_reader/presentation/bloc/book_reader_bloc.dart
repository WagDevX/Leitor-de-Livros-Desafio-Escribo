import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_local_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/remove_book.dart';
import 'package:ebook_reader/core/error/failure.dart';
import 'package:equatable/equatable.dart';

part 'book_reader_event.dart';
part 'book_reader_state.dart';

class BookReaderBloc extends Bloc<BookReaderEvent, BookReaderState> {
  BookReaderBloc({
    required DownloadBook download,
    required FavoriteBook favoriteBook,
    required GetBooks getBooks,
    required GetFavoriteBooks getFavoriteBooks,
    required GetLocalBooks getLocalBooks,
    required RemoveBook removeBook,
  })  : _download = download,
        _favoriteBook = favoriteBook,
        _getBooks = getBooks,
        _getFavoriteBooks = getFavoriteBooks,
        _getLocalBooks = getLocalBooks,
        _removeBook = removeBook,
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

  Future<void> _getFavoriteBooksHandler(
    GetFavoriteBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _getFavoriteBooks();

    result.fold((failure) => emit(GetBooksError(failure.errorMessage)),
        (book) => emit(FavoriteBooksLoaded(book)));
  }

  Future<void> _getRemoteBooksHandler(
    GetRemoteBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _getBooks();

    result.fold((failure) => emit(GetBooksError(failure.errorMessage)),
        (books) => emit(RemoteBooksLoaded(books)));
  }

  Future<void> _getLocalBooksHandler(
    GetLocalBooksEvent event,
    Emitter<BookReaderState> emit,
  ) async {
    final result = await _getLocalBooks();

    result.fold((failure) => emit(GetBooksError(failure.errorMessage)),
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
    final result = await _download(Book(
        id: event.id,
        title: event.title,
        author: event.author,
        coverUrl: event.coverUrl,
        downloadUrl: event.downloadUrl,
        favorite: event.favorite));

    result.fold((failure) => emit(DownloadBooksError(failure.errorMessage)),
        (_) => emit(const Downloaded()));
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
