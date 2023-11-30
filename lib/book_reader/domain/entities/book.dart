import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
    required this.favorite,
  });

  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  final bool favorite;

  const Book.empty()
      : this(
            id: "_emptyId",
            title: "_emptyTitle",
            author: "emptyAuthor",
            coverUrl: "emptyCoverUrl",
            downloadUrl: "emptyDownloadUrl",
            favorite: false);

  @override
  List<Object?> get props => [id, title, author, coverUrl, downloadUrl];
}
