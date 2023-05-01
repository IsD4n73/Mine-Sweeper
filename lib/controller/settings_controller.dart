import 'package:mine_sweeper/model/mine_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveGrid(int grid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('MS-grid', grid);
}

Future<int> getGrid() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  MineSweeper.col = prefs.getInt('MS-grid') ?? 5;
  MineSweeper.row = prefs.getInt('MS-grid') ?? 5;

  return prefs.getInt('MS-grid') ?? 5;
}

Future<bool> getAudio() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool('MS-audio') ?? false;
}

void saveAudio(bool audio) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool('MS-audio', audio);
}
