import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data_game.dart';
import '../game.dart';
import '../pages/desc_page.dart';

class JelajahiWidget extends StatefulWidget {
  JelajahiWidget({Key? key}) : super(key: key);

  @override
  _JelajahiWidgetState createState() => _JelajahiWidgetState();
}

class _JelajahiWidgetState extends State<JelajahiWidget> {
  List<GameData> data = data_game.map((e) => GameData.fromJson(e)).toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescPage(
                    avatar: data[index].avatar!,
                    name: data[index].name!,
                    genre: data[index].genre!,
                    rating: data[index].rating!,
                    desk: data[index].desk!,
                    imageUrl1: data[index].imageUrl1!,
                    imageUrl2: data[index].imageUrl2!,
                    imageUrl3: data[index].imageUrl3!,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menambahkan Container sebagai child Card
                Container(
                  width: double.infinity,
                  height: 120,
                  child: Image.network(
                    data[index].avatar!,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    data[index].name!,
                    style: GoogleFonts.bubblegumSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].genre!,
                        style: GoogleFonts.bubblegumSans(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        data[index].rating!,
                        style: GoogleFonts.bubblegumSans(
                          color: Colors.black54,
                        ),
                      ),
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
