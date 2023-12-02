import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:ebook_reader/core/services/injection_container.dart';
import 'package:ebook_reader/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<dynamic> favorites;

  void getBooks() async {
    context.read<BookReaderBloc>().add(const GetRemoteBooksEvent());
    final box = sl<Box<bool>>();
    favorites = box.keys.toList();
    debugPrint(favorites.toString());
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookReaderBloc, BookReaderState>(
        listener: (_, state) {},
        builder: (_, state) {
          if (state is BooksLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is RemoteBooksLoaded) {
            final books = state.book;
            final favoriteBooks = state.book
                .where((book) => favorites.contains(book.id))
                .toList();
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 0,
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: "Livros", icon: Icon(Icons.book)),
                        Tab(text: "Favoritos", icon: Icon(Icons.bookmark)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220, crossAxisCount: 2),
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return Column(
                              key: Key(index.toString()),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: 160,
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                NetworkImage(book.coverUrl))),
                                    child: Stack(children: [
                                      Positioned(
                                        top: -15,
                                        right: -20,
                                        child: IconButton(
                                          onPressed: () {
                                            // Atualizar localmente a lista de favoritos
                                            if (favorites.contains(book.id)) {
                                              favorites.remove(book.id);
                                              CoreUtils.showSnackBar(context,
                                                  '${book.title} removido dos favoritos!');
                                            } else {
                                              favorites.add(book.id);
                                              CoreUtils.showSnackBar(context,
                                                  '${book.title} favoritado!');
                                            }

                                            setState(() {});

                                            // Mostrar o Snackbar
                                          },
                                          icon: favorites.contains(book.id)
                                              ? const Icon(
                                                  Icons.bookmark,
                                                  size: 50,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.bookmark_border,
                                                  size: 50,
                                                ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          book.title,
                                          textAlign: TextAlign.center,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(book.author)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220, crossAxisCount: 2),
                          itemCount: favoriteBooks.length,
                          itemBuilder: (context, index) {
                            final book = favoriteBooks[index];
                            return Column(
                              key: Key(index.toString()),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: 160,
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                NetworkImage(book.coverUrl))),
                                    child: Stack(children: [
                                      Positioned(
                                        top: -15,
                                        right: -20,
                                        child: IconButton(
                                          onPressed: () {
                                            // Atualizar localmente a lista de favoritos
                                            if (favorites.contains(book.id)) {
                                              favorites.remove(book.id);
                                              CoreUtils.showSnackBar(context,
                                                  '${book.title} removido dos favoritos!');
                                            } else {
                                              favorites.add(book.id);
                                              CoreUtils.showSnackBar(context,
                                                  '${book.title} favoritado!');
                                            }

                                            setState(() {});

                                            // Mostrar o Snackbar
                                          },
                                          icon: favorites.contains(book.id)
                                              ? const Icon(
                                                  Icons.bookmark,
                                                  size: 50,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.bookmark_border,
                                                  size: 50,
                                                ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          book.title,
                                          textAlign: TextAlign.center,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(book.author)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}
