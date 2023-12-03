import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sorotangame/model/model.dart';

class Repository {
  final _baseUrl = 'https://www.freetogame.com/api/games';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Game> game = it.map((e) => Game.fromJson(e)).toList();
        return game;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
