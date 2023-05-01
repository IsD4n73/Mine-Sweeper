import "package:flutter/material.dart";
import "package:mine_sweeper/common/colors.dart";

import "../widgets/info_banner.dart";

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
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
              //todo open settings
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //! Banner mine and time !\\
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              InfoBanner(),
              InfoBanner(),
            ],
          ),
          //! Game Grid !\\
          Container(
            width: double.infinity,
            height: 500,
            padding: const EdgeInsets.all(20),
          )
        ],
      ),
    );
  }
}
