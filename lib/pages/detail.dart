import 'package:flutter/material.dart';
import 'package:sorotangame/model/game_data.dart';
import 'package:sorotangame/server/dbservice.dart';

class DetailGame extends StatefulWidget {
  final String name;

  const DetailGame({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailGame> createState() => _DetailGameState();
}

class _DetailGameState extends State<DetailGame> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataGame>(
      future: Database.getdataGame(name: widget.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text('No data available'),
            ),
          );
        }

        final dataGame = snapshot.data!;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(dataGame.name),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 235,
                  child: Image.network(
                    dataGame.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Judul komik
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataGame.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                dataGame.rating,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(133, 133, 151, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Text(
                        "Sinopsis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataGame.desk,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(133, 133, 151, 1),
                        ),
                      ),
                      // Tambahkan widget-widget lainnya sesuai kebutuhan
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
