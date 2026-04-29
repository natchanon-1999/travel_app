import 'package:flutter/material.dart';
import '../models/place.dart';

class DetailScreen extends StatelessWidget {
  final Place place;

  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: Column(
        children: [
          Image.network(place.image),
          SizedBox(height: 10),
          Text(place.name, style: TextStyle(fontSize: 22)),
          Text(place.description),
        ],
      ),
    );
  }
}