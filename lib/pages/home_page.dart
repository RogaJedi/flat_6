import 'package:flutter/material.dart';
import '../board_game_card.dart';
import '../game_page.dart';
import '../notes.dart';
import '../add_game.dart';

final Note Sample1 = Note(
  name: 'Каркассон',
  text: 'Настольная игра про строительство города.',
  imageUrl:
  'images/Karkasson.jpg',
  fullinfo:
  'Настольная игра "Каркассон" пользуется славой одной из лучших настольных игр мира. В чём превосходство "Каркассона"? В простых правилах, в многообразии партий, в их небольшой продолжительности, в отсутствии открытой конфронтации между игроками – это классический образец игры "в германском стиле".',
  cost: 1399,
  amount: 0,
);

final Note Sample2 = Note(
  name: 'Unmatched',
  text: 'Настольная игра про сражения легенд.',
  imageUrl:
  'images/UnMatched.jpg',
  fullinfo:
  'Мифологические персонажи, герои мультфильмов и художественной литературы появляются на одном поле для сражения! "Unmatched. Битва Легенд" – игра с простыми правилами, воплощающая в реальность детские фантазии о невозможных встречах вымышленных героев из разных вселенных. Каждый том содержит в себе карты с новыми персонажами, которые можно мешать с колодами из других серий.',
  cost: 3199,
  amount: 0,
);

final Note Sample3 = Note(
  name: 'Подземелья и пёсики',
  text: 'Настольная игра про побег из подземелья.',
  imageUrl:
  'images/p_and_p.jpg',
  fullinfo:
  'Добро пожаловать на состязание по побегу из подземелья! Нашим смелым хорошим мальчикам и девочкам предстоит спуститься в очень глубокие помещения (мы не знаем, кто их вырыл) и дать отпор страшным монстрам! Но наши участники не простые пёсики, а самые настоящие приключенцы. Кто из них соберёт больше всего вкусняшек и первым покинет мрачное подземелье?',
  cost: 899,
  amount: 0,
);

final Note Sample4 = Note(
  name: 'Мастера Пламени',
  text: 'Настольная игра про дракончиков.',
  imageUrl:
  'images/flamecraft.jpg',
  fullinfo:
  'Мастера Пламени — это очаровательные маленькие драконы, которые живут в небольшом городке в мире и согласии с людьми. Каждый игрок берёт на себя роль волшебника, который понимает язык этих удивительных созданий, а значит, может помочь городу процветать!',
  cost: 4499,
  amount: 0,
);

class HomePage extends StatefulWidget {
  final Set<Note> likedGames;
  final Set<Note> cartGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddCart;


  const HomePage({
    Key? key,
    required this.likedGames,
    required this.cartGames,
    required this.onLikedToggle,
    required this.onAddCart,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [Sample1, Sample2, Sample3, Sample4];

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddGame(onNoteAdded: this.addNewNote)),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        notes.add(result);
      });
    }
  }

  void addNewNote(Note newNote) {
    setState(() {
      notes.add(newNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настольные Игры'),
      ),
      body: Scrollbar(
        child: notes.isEmpty
            ? Center(child: Text('Пока что тут пусто, добавьте что-нибудь!'))
            : GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Количество столбцов в сетке
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.59, // Соотношение сторон элементов
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                      gameNote: note,
                      cartGames: widget.cartGames,
                      onAddCart: widget.onAddCart,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  BoardGameCard(
                    gameNote: note,
                  ),
                  const Positioned(
                    top: 17.25,
                    right: 17,
                    child: Icon(Icons.favorite, color: Colors.black, size: 30,)
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        widget.likedGames.contains(note)
                            ? Icons.favorite
                            : Icons.favorite,
                        color: widget.likedGames.contains(note)
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        widget.onLikedToggle(note);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: Icon(Icons.add),
        tooltip: 'Добавить игру',
      ),
    );
  }
}