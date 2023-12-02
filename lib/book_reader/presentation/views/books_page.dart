import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  void getBooks() {
    context.read<BookReaderBloc>().add(const GetRemoteBooksEvent());
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookReaderBloc, BookReaderState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RemoteBooksLoaded) {
            final books = state.book;
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
                                    child: const Stack(children: [
                                      Positioned(
                                        top: -6,
                                        right: -11,
                                        child: Icon(
                                          Icons.bookmark_border,
                                          size: 50,
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
                      Container()
                    ],
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}
