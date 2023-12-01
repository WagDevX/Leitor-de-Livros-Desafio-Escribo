import 'package:ebook_reader/book_reader/domain/repositories/remote_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class DownloadBook extends UseCaseWithParams<void, int> {
  DownloadBook(this._repository);

  final RemoteBookRepository _repository;

  @override
  ResultFuture<void> call(int params) async =>
      _repository.downloadBook(id: params);
}
