import "dart:async";

import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:mine_sweeper/common/colors.dart";
import "package:mine_sweeper/controller/timer_utils.dart";
import 'package:mine_sweeper/model/mine_game.dart';
import "package:mine_sweeper/pages/settings.dart";

import "../widgets/info_banner.dart";

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  MineSweeper game = MineSweeper();
  int secondTime = 0;
  bool isFirstMove = true;
  Timer timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("Mine Sweeper"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                secondTime = 0;
                timer.cancel();

                game.resetGame();
                game.gameOver = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //! Banner time !\\
            InfoBanner(formatedTime(time: secondTime), Icons.timer),
            //! Game Grid !\\
            Container(
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MineSweeper.row,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: game.cells,
                itemBuilder: (context, index) {
                  Color cellColor = game.gameMap[index].reveal
                      ? AppColor.clickedCard
                      : AppColor.lightPrimary;

                  return GestureDetector(
                    onTap: game.gameOver
                        ? null
                        : () {
                            setState(
                              () {
                                if (isFirstMove) {
                                  timer = Timer.periodic(
                                      const Duration(seconds: 1), (timer) {
                                    setState(() {
                                      secondTime++;
                                    });
                                  });
                                  AudioPlayer().play(AssetSource('assets/sounds/start.wav'));
                                  isFirstMove = false;
                                }
                                game.clickCell(game.gameMap[index]);
                                AudioPlayer().play(AssetSource('assets/sounds/click.wav'));

                                if (game.gameOver) {
                                  timer.cancel();
                                  AudioPlayer().play(AssetSource('assets/sounds/end.wav'));
                                }
                              },
                            );
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cellColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          game.gameMap[index].reveal
                              ? "${game.gameMap[index].content}"
                              : "",
                          style: TextStyle(
                            color: game.gameMap[index].reveal
                                ? game.gameMap[index].content == "X"
                                    ? Colors.red
                                    : AppColor.letterColors[
                                        game.gameMap[index].content]
                                : Colors.transparent,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //! Commands !\\
            Text(
              game.gameOver ? "You Lose" : "",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),

            const SizedBox(height: 20),

            RawMaterialButton(
              onPressed: () {
                setState(() {
                  secondTime = 0;
                  timer.cancel();

                  game.resetGame();
                  game.gameOver = false;
                });
              },
              fillColor: AppColor.lightPrimary,
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 64,
                vertical: 18,
              ),
              child: const Text(
                "Repeat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
