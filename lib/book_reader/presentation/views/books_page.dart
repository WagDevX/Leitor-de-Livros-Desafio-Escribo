import 'package:ebook_reader/book_reader/presentation/widgets/book_grid_view.dart';
import 'package:ebook_reader/book_reader/presentation/widgets/favorite_books_grid_view.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
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
