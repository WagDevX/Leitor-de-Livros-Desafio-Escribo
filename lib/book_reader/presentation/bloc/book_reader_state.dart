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

final class LocalBooksLoading extends BookReaderState {
  const LocalBooksLoading();
}

final class FavoriteBooksLoaded extends BookReaderState {
  const FavoriteBooksLoaded(this.book);
  final List<Book> book;

  @override
  List<Object> get props => book.map((book) => book.id).toList();
}

final class LocalBooksLoaded extends BookReaderState {
  const LocalBooksLoaded(this.book);
  final List<HiveBookModel> book;

  @override
  List<Object> get props => book.map((book) => book.id!).toList();
}

final class RemoteBooksLoaded extends BookReaderState {
  const RemoteBooksLoaded(this.book);
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

final class GetRemoteBooksError extends BookReaderState {
  const GetRemoteBooksError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

final class GetLocalBooksError extends BookReaderState {
  const GetLocalBooksError(this.message);
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

final class FavorieBookError extends BookReaderState {
  const FavorieBookError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}
