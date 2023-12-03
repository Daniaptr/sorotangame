import 'package:flutter/material.dart';
import 'package:sorotangame/model/view_model/fetch_data_game.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key});

  @override
  Widget build(BuildContext context) {
    Repository repo = Repository();
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Spotlight'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: repo.fetchDataPlaces(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _datagame(context, snapshot.data[index]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _datagame(BuildContext context, dynamic data_game) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   // context,
        //   // MaterialPageRoute(
        //   //   builder: (context) => DescPage(data_game: data_game),
        //   // ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF35385A).withOpacity(.12),
              blurRadius: 30,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(data_game.avatar),
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              data_game.name + " " + data_game.phoneNumber,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              data_game.address,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
