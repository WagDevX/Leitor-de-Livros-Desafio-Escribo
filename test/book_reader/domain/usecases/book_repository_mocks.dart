import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/repositories/remote_book_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteBookRepository extends Mock implements RemoteBookRepository {}

class MockLocalBookRepository extends Mock implements LocalBookRepository {}
