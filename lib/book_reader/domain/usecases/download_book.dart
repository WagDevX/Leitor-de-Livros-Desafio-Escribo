import 'package:ebook_reader/book_reader/domain/repository/book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class DownloadBook extends UseCaseWithParams<void, String> {
  DownloadBook(this._repository);

  final BookRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.downloadBook(id: params);
}
