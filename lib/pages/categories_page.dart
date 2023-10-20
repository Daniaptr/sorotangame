import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/data_game.dart';
import 'package:sorotangame/game.dart';
import 'package:sorotangame/pages/desc_page.dart';
import 'package:sorotangame/widgets/kategori_widget.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // Declare a TextEditingController for the search field
  TextEditingController searchController = TextEditingController();

  List<GameData> data = data_game.map((e) => GameData.fromJson(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: GoogleFonts.bubblegumSans(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xffc1aebe),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(65, 170, 170, 170),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 50,
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Category...",
                      ),
                      controller:
                          searchController, // Assign the searchController
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    size: 27,
                    color: Color(0xffc1aebe),
                  ),
                ],
              ),
            ),
          ),
          CategoriesWidget(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(14.0),
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
                          backgroundImage: NetworkImage(data[index].avatar!),
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
                                  Icons.star,
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
            ),
          ),
        ],
      ),
    );
  }
}
