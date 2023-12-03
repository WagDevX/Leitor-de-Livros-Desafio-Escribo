import 'package:ebook_reader/book_reader/domain/entities/book.dart';
import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:ebook_reader/core/services/injection_container.dart';
import 'package:ebook_reader/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BooksGridView extends StatefulWidget {
  const BooksGridView({super.key});

  @override
  State<BooksGridView> createState() => _BooksGridViewState();
}

class _BooksGridViewState extends State<BooksGridView> {
  late Box<bool> favorites;

  List<Book> booksList = [];

  void getBooks() async {
    context.read<BookReaderBloc>().add(const GetRemoteBooksEvent());
    final box = sl<Box<bool>>();
    favorites = box;
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookReaderBloc, BookReaderState>(listener: (_, state) {
      if (state is RemoteBooksLoaded) {
        booksList = state.book;
      }
      if (state is GetBooksError) {
        CoreUtils.showSnackBar(context, state.message);
      }
    }, builder: (_, state) {
      // if (state is BooksLoading) {
      //   return const Center(child: CircularProgressIndicator());
      // }
      // if (state is GetBooksError) {
      //   return Center(child: Text(state.message));
      // }
      print(state.toString());
      return GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 220, crossAxisCount: 2),
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            final book = booksList[index];
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(book.coverUrl))),
                    child: Stack(children: [
                      Positioned(
                        top: -15,
                        right: -20,
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<BookReaderBloc>()
                                .add(FavoriteBookEvent(id: book.id));
                            getBooks();
                          },
                          icon: favorites.get(book.id) != null
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
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(book.author)
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    });
  }
}
