import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sorotangame/model/game_data.dart';

class PopularWidget extends StatefulWidget {
  PopularWidget({Key? key}) : super(key: key);

  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  late Stream<QuerySnapshot> sorotangame;

  @override
  void initState() {
    super.initState();
    sorotangame = Database.getData();
    // sorotangame = FirebaseFirestore.instance.collection('game').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
<<<<<<< HEAD
      child: StreamBuilder<QuerySnapshot>(
        stream: sorotangame,
        builder: (context, snapshot) {
          print("Connection State: ${snapshot.connectionState}");
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color.fromARGB(115, 206, 43, 43),
=======
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          Map<String, dynamic> game = data_game[index];
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    ),
                child: Column(
                  children: [
                    Image.network(
                      game['imageUrl1'],
                      fit: BoxFit.cover,
                    ),
                  ],
>>>>>>> 7886a56aa30fb3dd0b92fe27dc20c1fb389e0d30
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> items = snapshot.data!.docs;

            return CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                DocumentSnapshot game = items[index]; // Ambil data per item

                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          ),
                      child: Column(
                        children: [
                          Image.network(
                            game['imageUrl1'],
                            fit: BoxFit.cover,
                          ),
                          // Tambahkan widget lainnya di sini sesuai kebutuhan
                        ],
                      ),
                    );
                  },
                );
              },
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
            );
          }
          return SizedBox(); // Return widget kosong jika tidak ada data
        },
      ),
    );
  }
}
