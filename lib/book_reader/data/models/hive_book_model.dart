import 'package:hive/hive.dart';

part 'hive_book_model.g.dart';

@HiveType(typeId: 1)
class HiveBookModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? coverUrl;

  @HiveField(4)
  String? downloadUrl;

  @HiveField(5)
  bool? favorite;

  HiveBookModel();

  HiveBookModel.criar() {
    id;
    title;
    author;
    coverUrl;
    downloadUrl;
    favorite = false;
  }
}
