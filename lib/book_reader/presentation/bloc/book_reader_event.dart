part of 'book_reader_bloc.dart';

sealed class BookReaderEvent extends Equatable {
  const BookReaderEvent();

  @override
  List<Object> get props => [];
}

class FavoriteBookEvent extends BookReaderEvent {
  const FavoriteBookEvent({required this.id});

  final int id;

  @override
  List<int> get props => [id];
}

class DownlaodBookEvent extends BookReaderEvent {
  const DownlaodBookEvent({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
    required this.favorite,
  });

  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  final bool favorite;

  @override
  List<Object> get props => [id, title, author, coverUrl, downloadUrl];
}

class GetRemoteBooksEvent extends BookReaderEvent {
  const GetRemoteBooksEvent();
}

class GetLocalBooksEvent extends BookReaderEvent {
  const GetLocalBooksEvent();
}

class GetFavoriteBooksEvent extends BookReaderEvent {
  const GetFavoriteBooksEvent();
}

class RemoveBookEvent extends BookReaderEvent {
  const RemoveBookEvent({required this.key});

  final String key;

  @override
  List<String> get props => [key];
}
