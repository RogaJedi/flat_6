import 'package:flutter/material.dart';
import 'notes.dart';

class GamePage extends StatelessWidget {
  final Note gameNote;
  final Set<Note> cartGames;
  final Function(Note) onAddCart;

  const GamePage({
    Key? key,
    required this.gameNote,
    required this.cartGames,
    required this.onAddCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameNote.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(gameNote.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameNote.text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    gameNote.fullinfo,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff504bff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed:() => onAddCart(gameNote),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Добавить в корзину",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),


                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
