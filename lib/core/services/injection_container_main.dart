part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final Box<bool> favoriteBooksBox =
      await Hive.openBox<bool>(favoriteBooksHiveBoxName);
  final Box<HiveBookModel> booksBox = await Hive.openBox(booksHiveBoxName);
  sl
    ..registerFactory(() => BookReaderBloc(
          download: sl(),
          favoriteBook: sl(),
          getBooks: sl(),
          getFavoriteBooks: sl(),
          getLocalBooks: sl(),
          removeBook: sl(),
          booksBox: sl(),
        ))
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
        () => BookLocalDataSourceImpl(favoriteBooksBox: sl(), booksBox: sl()))
    ..registerLazySingleton<BookRemoteDataSource>(
        () => BookRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => favoriteBooksBox)
    ..registerLazySingleton(() => booksBox);
}
