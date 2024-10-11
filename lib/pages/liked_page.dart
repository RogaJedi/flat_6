import 'package:flutter/material.dart';
import '../notes.dart';
import '../board_game_card.dart';
import '../game_page.dart';

class LikedPage extends StatelessWidget {
  final Set<Note> likedGames;
  final Set<Note> cartGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddCart;

  const LikedPage({
    Key? key,
    required this.likedGames,
    required this.cartGames,
    required this.onLikedToggle,
    required this.onAddCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likedGamesList = likedGames.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.59, // Adjust as needed
        ),
        itemCount: likedGamesList.length,
        itemBuilder: (BuildContext context, int index) {
          final note = likedGamesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    gameNote: note,
                    cartGames: cartGames,
                    onAddCart: onAddCart,
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
                    top: 17.35,
                    right: 17,
                    child: Icon(Icons.favorite, color: Colors.black, size: 30,)
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      onLikedToggle(note);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}