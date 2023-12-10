import 'package:flutter/material.dart';
import 'package:sorotangame/model/data_game.dart';
import 'package:sorotangame/model/view_model/fetch_data_game.dart';

// ... (imports and other parts of the code remain unchanged)

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
        child: FutureBuilder<List<DataGame>>(
          future: repo.fetchDataPlaces(),
          builder:
              (BuildContext context, AsyncSnapshot<List<DataGame>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentData = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(currentData.imageUrl1),
                    ),
                    title: Text(currentData.rating + " " + currentData.name),
                    subtitle: Text(currentData.desk),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
