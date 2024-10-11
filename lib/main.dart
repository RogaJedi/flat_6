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
  List<Note> baseNotes = [
      Note(
        name: 'Каркассон',
        text: 'Настольная игра про строительство города.',
        imageUrl:
        'images/Karkasson.jpg',
        fullinfo:
        'Настольная игра "Каркассон" пользуется славой одной из лучших настольных игр мира. В чём превосходство "Каркассона"? В простых правилах, в многообразии партий, в их небольшой продолжительности, в отсутствии открытой конфронтации между игроками – это классический образец игры "в германском стиле".',
        cost: 1399,
        amount: 0,
      ),
      Note(
        name: 'Unmatched',
        text: 'Настольная игра про сражения легенд.',
        imageUrl:
        'images/UnMatched.jpg',
        fullinfo:
        'Мифологические персонажи, герои мультфильмов и художественной литературы появляются на одном поле для сражения! "Unmatched. Битва Легенд" – игра с простыми правилами, воплощающая в реальность детские фантазии о невозможных встречах вымышленных героев из разных вселенных. Каждый том содержит в себе карты с новыми персонажами, которые можно мешать с колодами из других серий.',
        cost: 3199,
        amount: 0,
      ),
      Note(
        name: 'Подземелья и пёсики',
        text: 'Настольная игра про побег из подземелья.',
        imageUrl:
        'images/p_and_p.jpg',
        fullinfo:
        'Добро пожаловать на состязание по побегу из подземелья! Нашим смелым хорошим мальчикам и девочкам предстоит спуститься в очень глубокие помещения (мы не знаем, кто их вырыл) и дать отпор страшным монстрам! Но наши участники не простые пёсики, а самые настоящие приключенцы. Кто из них соберёт больше всего вкусняшек и первым покинет мрачное подземелье?',
        cost: 899,
        amount: 0,
      ),
      Note(
        name: 'Мастера Пламени',
        text: 'Настольная игра про дракончиков.',
        imageUrl:
        'images/flamecraft.jpg',
        fullinfo:
        'Мастера Пламени — это очаровательные маленькие драконы, которые живут в небольшом городке в мире и согласии с людьми. Каждый игрок берёт на себя роль волшебника, который понимает язык этих удивительных созданий, а значит, может помочь городу процветать!',
        cost: 4499,
        amount: 0,
      ),
  ];

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

  void _deleteProduct(Note note) {
    setState(() {
      baseNotes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        onDeleteProduct: _deleteProduct,
        baseNotes: baseNotes,
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
      ),
      LikedPage(
        onDeleteProduct: _deleteProduct,
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
      ),
      CartPage(
        onDeleteProduct: _deleteProduct,
        cartGames: cartGames,
        likedGames: likedGames,
        onAddToCart: _addToCart,
        onLikedToggle: _toggleFavorite,
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
