import 'package:ebook_reader/book_reader/presentation/bloc/book_reader_bloc.dart';
import 'package:ebook_reader/book_reader/presentation/widgets/book_grid_view.dart';
import 'package:ebook_reader/book_reader/presentation/widgets/favorite_books_grid_view.dart';
import 'package:ebook_reader/core/services/injection_container.dart';
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
          body: const TabBarView(
            children: [BooksGridView(), FavoriteBooksGridView()],
          )),
    );
  }
}
