import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/place.dart';

class EditScreen extends StatefulWidget {
  final Place place;

  EditScreen({required this.place});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController descCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.place.name);
    descCtrl = TextEditingController(text: widget.place.description);
  }

  Future updatePlace() async {
    await http.post(
      Uri.parse("http://localhost/travel_app/php_api/update_place.php"),
      body: {
        "id": widget.place.id.toString(),
        "name": nameCtrl.text,
        "description": descCtrl.text,
      },
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("แก้ไขข้อมูล")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(widget.place.image),

            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "ชื่อ"),
            ),

            TextField(
              controller: descCtrl,
              decoration: InputDecoration(labelText: "รายละเอียด"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: updatePlace,
              child: Text("บันทึก"),
            ),
          ],
        ),
      ),
    );
  }
}