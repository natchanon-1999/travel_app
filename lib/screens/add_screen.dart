import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController imageCtrl = TextEditingController();

  Future addPlace() async {
    await http.post(
      Uri.parse("http://localhost/travel_app/php_api/add_place.php"),
      body: {
        "name": nameCtrl.text,
        "description": descCtrl.text,
        "image": imageCtrl.text,
      },
    );

    Navigator.pop(context); // กลับหน้าแรก
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มสถานที่")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "ชื่อสถานที่"),
            ),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(labelText: "รายละเอียด"),
            ),
            TextField(
              controller: imageCtrl,
              decoration: InputDecoration(labelText: "URL รูปภาพ"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addPlace,
              child: Text("เพิ่มข้อมูล"),
            ),
          ],
        ),
      ),
    );
  }
}