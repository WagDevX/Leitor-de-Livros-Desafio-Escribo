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

final class FavoriteBooksLoaded extends BookReaderState {
  const FavoriteBooksLoaded(this.book);
  final List<Book> book;

  @override
  List<Object> get props => book.map((book) => book.id).toList();
}

final class LocalBooksLoaded extends BookReaderState {
  const LocalBooksLoaded(this.book);
  final List<Book> book;

  @override
  List<Object> get props => book.map((book) => book.id).toList();
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

final class Downloaded extends BookReaderState {
  const Downloaded();
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
