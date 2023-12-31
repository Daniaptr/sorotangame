import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/model/game_data.dart';
import 'package:sorotangame/pages/categories_page.dart';
import 'package:sorotangame/pages/desc_page.dart';
import 'package:sorotangame/pages/profile.dart';
import 'package:sorotangame/server/dbservice.dart';
import 'package:sorotangame/widgets/popular_widget.dart';

import '../../widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // _HomePageState createState() => _HomePageState();
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String selectedButton;
  MyUser? _currentUser;
  late Stream<QuerySnapshot> sorotangame;

  @override
  void initState() {
    super.initState();
    selectedButton = 'name'; // Set nilai default saat inisialisasi state
  }

  int _selectedPage = 0;
  final List<Widget> _pages = [
    MainView(sorotangame: Database.getData()),
    CategoriesView(
        searchController: TextEditingController(),
        initialData: Database.getData()),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xffc1aebe),
        index: 0,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.grid_view_sharp, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
      body: _pages[_selectedPage],
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}

class MainView extends StatefulWidget {
  MainView({
    Key? key,
    required this.sorotangame,
  }) : super(key: key);

  Stream<QuerySnapshot> sorotangame;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
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
          PopularWidget(),
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
                SizedBox(
                  child: Container(
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
                ),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: widget.sorotangame,
                    builder: (context, snapshot) {
                      print("Connection State: ${snapshot.connectionState}");
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color.fromARGB(115, 206, 43, 43),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        List<DocumentSnapshot> items = snapshot.data!.docs;

                        // Menggunakan kondisi jika ada hasil pencarian, tampilkan hasil pencarian, jika tidak, tampilkan pesan
                        if (items.isEmpty) {
                          return Center(
                            child: Text(
                              "No search results",
                              style: GoogleFonts.bubblegumSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffc1aebe),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5, // Menampilkan semua hasil pencarian
                            itemBuilder: (context, index) {
                              DocumentSnapshot game = items[index];
                              String lvname = game["name"];
                              String lvavatar = game["avatar"];
                              String lvrating = game["rating"];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DescPage(
                                        avatar: game[
                                            "avatar"], // Menggunakan game["avatar"] karena game adalah item hasil pencarian saat ini
                                        name: lvname,
                                        genre: game["genre"],
                                        rating: lvrating,
                                        desk: game["desk"],
                                        imageUrl1: game["imageUrl1"],
                                        imageUrl2: game["imageUrl2"],
                                        imageUrl3: game["imageUrl3"],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                NetworkImage(lvavatar),
                                          ),
                                          SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lvname,
                                                  style:
                                                      GoogleFonts.bubblegumSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  game["genre"],
                                                  style:
                                                      GoogleFonts.bubblegumSans(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Rating: ',
                                                      style: GoogleFonts
                                                          .bubblegumSans(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      lvrating.length > 14
                                                          ? '${lvrating.substring(0, 14)}...'
                                                          : lvrating,
                                                      style: GoogleFonts
                                                          .bubblegumSans(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return SizedBox(
                          child: Text("No Data"),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
