import 'package:flutter/material.dart';
import 'package:mine_sweeper/common/colors.dart';
import 'package:mine_sweeper/controller/settings_controller.dart';
import 'package:mine_sweeper/pages/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getGrid();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mine Sweeper',
      theme: ThemeData(
        unselectedWidgetColor: AppColor.clickedCard,
      ),
      home: const GameScreen(),
    );
  }
}
