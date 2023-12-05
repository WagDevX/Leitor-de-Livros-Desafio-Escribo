part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final Box<bool> favoriteBooksBox =
      await Hive.openBox<bool>(favoriteBooksHiveBoxName);
  final Box<HiveBookModel> booksBox = await Hive.openBox(booksHiveBoxName);
  final InternetConnection internetCheker = InternetConnection();
  sl
    ..registerFactory(() => BookReaderBloc(
          download: sl(),
          favoriteBook: sl(),
          getBooks: sl(),
          getFavoriteBooks: sl(),
          removeBook: sl(),
          booksBox: sl(),
        ))
    ..registerLazySingleton(() => DownloadBook(sl()))
    ..registerLazySingleton(() => FavoriteBook(sl()))
    ..registerLazySingleton(() => GetBooks(sl()))
    ..registerLazySingleton(() => GetFavoriteBooks(sl()))
    ..registerLazySingleton(() => RemoveBook(sl()))
    ..registerLazySingleton<BooksRepository>(() => BooksRepositoryImpl(sl()))
    ..registerLazySingleton<BookDataSource>(() => BookDataSourceImpl(
        favoriteBooksBox: sl(),
        booksBox: sl(),
        internetChecker: sl(),
        client: sl()))
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => favoriteBooksBox)
    ..registerLazySingleton(() => booksBox)
    ..registerLazySingleton(() => internetCheker);
}
