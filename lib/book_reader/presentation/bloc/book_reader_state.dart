part of 'book_reader_bloc.dart';

sealed class BookReaderState extends Equatable {
  const BookReaderState();

  @override
  List<Object> get props => [];
}

final class BookReaderInitial extends BookReaderState {}

final class BooksLoading extends BookReaderState {
  const BooksLoading();
}

final class FavoriteBooksLoading extends BookReaderState {
  const FavoriteBooksLoading();
}

final class FavoriteBooksLoaded extends BookReaderState {
  const FavoriteBooksLoaded(this.book);
  final List<Book> book;

  @override
  List<Object> get props => book.map((book) => book.id).toList();
}

final class BooksLoaded extends BookReaderState {
  const BooksLoaded(this.book);
  final List<Book> book;

  @override
  List<Object> get props => book.map((book) => book.id).toList();
}

final class Downloading extends BookReaderState {
  const Downloading();
}

final class OpeningBook extends BookReaderState {
  const OpeningBook();
}

final class Downloaded extends BookReaderState {
  const Downloaded(this.downloadedBook);
  final Book downloadedBook;

  @override
  List<Object> get props => [downloadedBook];
}

final class BookOpenedFromDisk extends BookReaderState {
  const BookOpenedFromDisk(this.openedBook);
  final Book openedBook;

  @override
  List<Object> get props => [openedBook];
}

final class BookFavorited extends BookReaderState {
  const BookFavorited();
}

final class BookDeleted extends BookReaderState {
  const BookDeleted();
}

final class GetBooksError extends BookReaderState {
  const GetBooksError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

final class GetFavoriteBooksError extends BookReaderState {
  const GetFavoriteBooksError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

final class FavoriteBookError extends BookReaderState {
  const FavoriteBookError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

final class DownloadBooksError extends BookReaderState {
  const DownloadBooksError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

final class RemoveBookError extends BookReaderState {
  const RemoveBookError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}
