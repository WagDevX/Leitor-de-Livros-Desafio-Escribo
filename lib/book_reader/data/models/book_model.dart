import 'dart:convert';

import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
    super.favorite = false,
  });

  const BookModel.empty()
      : this(
            id: "emptyId",
            title: "emptyTitle",
            author: "emtpyAuthor",
            coverUrl: "emptyCoverUrl",
            downloadUrl: "emptyDownloadUrl",
            favorite: false);

  BookModel.fromMap(DataMap map)
      : this(
          id: map["id"] as String,
          title: map["title"] as String,
          author: map["author"] as String,
          coverUrl: map["coverUrl"] as String,
          downloadUrl: map["downloadUrl"] as String,
        );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'downloadUrl': downloadUrl,
        'favorite': favorite
      };

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(jsonDecode(source) as DataMap);

  String toJson() => jsonEncode(toMap());

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
    bool? favorite,
  }) {
    return BookModel(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverUrl: coverUrl ?? this.coverUrl,
        downloadUrl: downloadUrl ?? this.coverUrl);
  }
}
