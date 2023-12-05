import 'dart:convert';

import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
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

  BookModel.fromHiveModel(HiveBookModel hiveBook)
      : this(
          id: hiveBook.id ?? 0, // Provide a default value if id is nullable
          title: hiveBook.title ?? "",
          author: hiveBook.author ?? "",
          coverUrl: hiveBook.coverUrl ?? "",
          downloadUrl: hiveBook.downloadUrl ?? "",
          favorite: hiveBook.favorite ?? false,
        );

  const BookModel.empty()
      : this(
            id: 1,
            title: "emptyTitle",
            author: "emtpyAuthor",
            coverUrl: "emptyCoverUrl",
            downloadUrl: "emptyDownloadUrl",
            favorite: false);

  BookModel.fromMap(DataMap map)
      : this(
          id: map["id"] as int,
          title: map["title"] as String,
          author: map["author"] as String,
          coverUrl: map["cover_url"] as String,
          downloadUrl: map["download_url"] as String,
        );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'cover_url': coverUrl,
        'download_url': downloadUrl,
        'favorite': favorite
      };

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(jsonDecode(source) as DataMap);

  String toJson() => jsonEncode(toMap());

  BookModel copyWith({
    int? id,
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
        downloadUrl: downloadUrl ?? this.downloadUrl);
  }
}
