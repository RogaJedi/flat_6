import 'package:flutter/material.dart';
import 'notes.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/liked_page.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Set<Note> likedGames = {};
  final Set<Note> cartGames = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      if (likedGames.contains(note)) {
        likedGames.remove(note);
      } else {
        likedGames.add(note);
      }
    });
  }

  void _addToCart(Note note) {
    setState(() {
      note.amount += 1;
      cartGames.add(note);
    });
  }

  void _removeFromCart(Note note) {
    setState(() {
      note.amount -= 1;
    });
  }

  void _deleteFromCart(Note note) {
    setState(() {
      note.amount = 0;
      cartGames.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
      ),
      LikedPage(
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
      ),
      CartPage(
        cartGames: cartGames,
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart,
        onDeleteFromCart: _deleteFromCart,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,  // Add this line
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff504bff),
        unselectedItemColor: Colors.grey,  // Add this to ensure visibility of unselected icons
        onTap: _onItemTapped,
      ),
    );

  }
}
