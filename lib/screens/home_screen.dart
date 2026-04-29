import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/place.dart';
import 'detail_screen.dart';
import 'edit_screen.dart';
import 'add_screen.dart'; // 👈 สำคัญ

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> places = [];
  List<Place> filtered = [];

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  Future fetchPlaces() async {
    try {
      final res = await http.get(
        Uri.parse("http://localhost/travel_app/php_api/get_places.php"),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        setState(() {
          places = data.map<Place>((e) => Place.fromJson(e)).toList();
          filtered = places;
        });
      }
    } catch (e) {
      print("Error fetch: $e");
    }
  }

  void search(String value) {
    setState(() {
      filtered = places
          .where((p) =>
              p.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<bool> deletePlace(int id) async {
    try {
      final res = await http.post(
        Uri.parse("http://localhost/travel_app/php_api/delete_place.php"),
        body: {"id": id.toString()},
      );

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ยืนยันการลบ"),
        content: Text("ต้องการลบรายการนี้ใช่ไหม?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ยกเลิก"),
          ),
          TextButton(
            onPressed: () async {
              bool success = await deletePlace(id);

              Navigator.pop(context);

              if (success) {
                fetchPlaces();
              }
            },
            child: Text("ลบ", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel List")),

      // 🔥 ปุ่ม +
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddScreen()),
          ).then((_) => fetchPlaces());
        },
        child: Icon(Icons.add),
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search place",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final p = filtered[index];

                return ListTile(
                  leading: Image.network(p.image, width: 60),
                  title: Text(p.name),
                  subtitle: Text(p.description),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == "edit") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditScreen(place: p),
                          ),
                        ).then((_) => fetchPlaces());
                      }

                      if (value == "delete") {
                        showDeleteDialog(p.id);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: "edit", child: Text("แก้ไข")),
                      PopupMenuItem(value: "delete", child: Text("ลบ")),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(place: p),
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