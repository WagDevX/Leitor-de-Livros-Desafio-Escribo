import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class FavoriteBook extends UseCaseWithParams<void, int> {
  FavoriteBook(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<void> call(int params) => _repository.favoriteBook(id: params);
}
