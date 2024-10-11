import 'package:flutter/material.dart';
import 'notes.dart';

class GamePage extends StatefulWidget {
  final Note gameNote;
  final Set<Note> cartGames;
  final Set<Note> likedGames;
  final Function(Note) onAddCart;
  final Function(Note) onLikedToggle;
  final Function(Note) onDeleteProduct;

  const GamePage({
    Key? key,
    required this.gameNote,
    required this.cartGames,
    required this.likedGames,
    required this.onAddCart,
    required this.onLikedToggle,
    required this.onDeleteProduct,

  }) : super(key: key);


  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameNote.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 120,
                      width: 100,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Вы хотите удалить этот товар?"),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onDeleteProduct(widget.gameNote);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Да"),
                                ),
                                const SizedBox(width: 6),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text("Нет"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            tooltip: 'Удалить товар',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(widget.gameNote.imageUrl),
                const Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.favorite, color: Colors.white,)
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      widget.likedGames.contains(widget.gameNote)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.likedGames.contains(widget.gameNote)
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.onLikedToggle(widget.gameNote);
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.gameNote.text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.gameNote.fullinfo,
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
                      onPressed:() => widget.onAddCart(widget.gameNote),
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
