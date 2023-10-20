import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/data_game.dart';
import 'package:sorotangame/game.dart';
import 'package:sorotangame/pages/desc_page.dart';
import 'package:sorotangame/widgets/popular_widget.dart';

import '../../widgets/home_app_bar.dart';
import '../../widgets/kategori_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameData> data = data_game.map((e) => GameData.fromJson(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Game...",
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.gamepad,
                        size: 27,
                        color: Color(0xffc1aebe),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                    "POPULAR 🔥",
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc1aebe),
                    ),
                  ),
                ),
                // Popular game
                PopularWidget(),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Select Category",
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc1aebe),
                    ),
                  ),
                ),

                // Kategori
                CategoriesWidget(),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    "Explore Popular Games",
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc1aebe),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data_game.length > 5
                      ? 5
                      : data_game.length, // Hanya menampilkan 5 data
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors
                                .grey), // Menambahkan border pada setiap item
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Mengatur sudut kotak
                      ),
                      margin:
                          EdgeInsets.all(8.0), // Menambahkan margin antara item
                      padding: EdgeInsets.all(
                          14.0), // Menambahkan padding agar lebih rapi
                      child: GestureDetector(
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
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(data[index].avatar!),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name!,
                                  style: GoogleFonts.bubblegumSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data[index].genre!,
                                  style: GoogleFonts.bubblegumSans(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Rating: ',
                                      style: GoogleFonts.bubblegumSans(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      ' ${data[index].rating}',
                                      style: GoogleFonts.bubblegumSans(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star, // Icon bintang
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
