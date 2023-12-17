import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/model/game_data.dart';
import 'package:sorotangame/pages/desc_page.dart';
import 'package:sorotangame/widgets/kategori_widget.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  TextEditingController searchController = TextEditingController();

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
      body: CategoriesView(
        searchController: searchController,
        initialData: Database.getData(), // Gunakan data awal
      ),
    );
  }
}

class CategoriesView extends StatefulWidget {
  CategoriesView({
    Key? key,
    required this.searchController,
    required this.initialData,
  }) : super(key: key);

  final TextEditingController searchController;
  final Stream<QuerySnapshot> initialData;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late Stream<QuerySnapshot> _currentData;

  @override
  void initState() {
    super.initState();
    _currentData = widget.initialData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                    width: 250,
                    child: TextFormField(
                      style: GoogleFonts.bubblegumSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffc1aebe),
                      ),
                      controller: widget.searchController,
                      onChanged: (value) {
                        setState(() {
                          _currentData = Database.searchDataGame(value);
                        });
                      },
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
          ),
          CategoriesWidget(),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _currentData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color.fromARGB(115, 206, 43, 43),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Data"),
                  );
                }

                List<DocumentSnapshot> items = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescPage(
                              avatar: items[index]["avatar"],
                              name: items[index]["name"],
                              genre: items[index]["genre"],
                              rating: items[index]["rating"],
                              desk: items[index]["desk"],
                              imageUrl1: items[index]["imageUrl1"],
                              imageUrl2: items[index]["imageUrl2"],
                              imageUrl3: items[index]["imageUrl3"],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(items[index]["avatar"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index]["name"],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    items[index]["genre"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Rating: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        ' ${items[index]["rating"]}',
                                        style: TextStyle(
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
