import 'package:ebook_reader/book_reader/data/models/hive_book_model.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/core/usecases/usecases.dart';
import 'package:ebook_reader/core/utils/typedef.dart';

class GetLocalBooks extends UseCaseWithOutParams<List<HiveBookModel>> {
  const GetLocalBooks(this._repository);

  final LocalBookRepository _repository;

  @override
  ResultFuture<List<HiveBookModel>> call() async => _repository.getBooks();
}
