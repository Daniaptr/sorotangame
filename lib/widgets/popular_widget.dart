import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../data_game.dart';
import '../game.dart';

class PopularWidget extends StatelessWidget {
  List<GameData> data = data_game.map((e) => GameData.fromJson(e)).toList();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
      ),
    );
  }
}
