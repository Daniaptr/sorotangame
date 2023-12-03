import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sorotangame/model/data_game.dart';

class Repository {
  final String apiUrl =
      "https://gamespotlight-18d27-default-rtdb.firebaseio.com/game.json";

  Future<List<DataGame>> fetchDataPlaces() async {
    Response response = await http.get(Uri.parse(apiUrl));
    List<DataGame> dataPlaces;
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      dataPlaces = jsonData.values.map((value) {
        return DataGame.fromJson(value);
      }).toList();

      return dataPlaces;
    } else {
      throw Exception('Failed to load data places');
    }
  }
}
