import "package:chips_choice/chips_choice.dart";
import "package:flutter/material.dart";
import "package:mine_sweeper/controller/settings_controller.dart";
import 'package:mine_sweeper/model/mine_game.dart';
import "package:mine_sweeper/pages/game.dart";

import "../common/colors.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int tag = 0;

  @override
  void initState() {
    super.initState();

    getGrid().then((value) {
      if (value == 10) {
        setState(() {
          tag = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("Mine Sweeper Settings"),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GameScreen(),
            ),
          ),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              //! Grid Size !\\
              const Text(
                "GRID SIZE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              ChipsChoice<int>.single(
                value: tag,
                onChanged: (val) {
                  if (val == 0) {
                    saveGrid(5);
                    MineSweeper.col = 5;
                    MineSweeper.row = 5;
                  } else {
                    saveGrid(10);
                    MineSweeper.col = 10;
                    MineSweeper.row = 10;
                  }
                  setState(() {
                    tag = val;
                  });
                },
                choiceStyle: C2ChipStyle.filled(
                  selectedStyle: C2ChipStyle(
                    backgroundColor: AppColor.accent,
                  ),
                  color: Colors.white,
                ),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: ["5x5", "10x10"],
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}