import 'package:shared_preferences/shared_preferences.dart';

void saveGrid(int grid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('MS-grid', grid);
}

Future<int> getGrid() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('MS-grid') ?? 5;
}
