import 'package:ebook_reader/book_reader/data/datasources/local_data_source/book_local_data_source.dart';
import 'package:ebook_reader/book_reader/data/datasources/local_data_source/impl/book_local_data_source_impl.dart';
import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/book_remote_data_source.dart';
import 'package:ebook_reader/book_reader/data/datasources/remote_data_source/impl/book_remote_data_source_impl.dart';
import 'package:ebook_reader/book_reader/data/models/book_model.dart';
import 'package:ebook_reader/book_reader/data/repositories/local_book_repository_implementation.dart';
import 'package:ebook_reader/book_reader/data/repositories/remote_book_repository_implementation.dart';
import 'package:ebook_reader/book_reader/domain/repositories/local_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/repositories/remote_book_repository.dart';
import 'package:ebook_reader/book_reader/domain/usecases/download_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/favorite_book.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_favorite_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/get_local_books.dart';
import 'package:ebook_reader/book_reader/domain/usecases/remove_book.dart';
import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:ebook_reader/core/utils/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  final favoritesBox = await Hive.openBox<bool?>(favoriteBooksHiveBoxName);
  final booksBox = await Hive.openBox<BookModel?>(booksHiveBoxName);
  sl
    ..registerFactory(() => BookReaderBloc(
        download: sl(),
        favoriteBook: sl(),
        getBooks: sl(),
        getFavoriteBooks: sl(),
        getLocalBooks: sl(),
        removeBook: sl()))
    ..registerLazySingleton(() => DownloadBook(sl()))
    ..registerLazySingleton(() => FavoriteBook(sl()))
    ..registerLazySingleton(() => GetBooks(sl()))
    ..registerLazySingleton(() => GetFavoriteBooks(sl()))
    ..registerLazySingleton(() => GetLocalBooks(sl()))
    ..registerLazySingleton(() => RemoveBook(sl()))
    ..registerLazySingleton<LocalBookRepository>(
        () => LocalBookRepositoryImpl(sl()))
    ..registerLazySingleton<RemoteBookRepository>(
        () => RemoteBookRemositoryImpl(sl()))
    ..registerLazySingleton<BookLocalDataSource>(
        () => BookLocalDataSourceImpl(sl(), sl()))
    ..registerLazySingleton<BookRemoteDataSource>(
        () => BookRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => favoritesBox)
    ..registerLazySingleton(() => booksBox);
}
