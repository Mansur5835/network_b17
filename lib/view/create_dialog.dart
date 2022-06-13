import 'package:flutter/material.dart';
import 'package:flutter_network/models/user_model.dart';
import 'package:flutter_network/services/network_service.dart';

Future<String?> createDialogShow(context) async {
  TextEditingController nameEditText = TextEditingController();
  TextEditingController numberEditText = TextEditingController();
  String? newUser;
  User? user;
  await showDialog(
      context: context,
      builder: (afsdfasdf) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () async {
                  user = User(
                      name: nameEditText.text.toString(),
                      phoneNumber: numberEditText.text.toString(),
                      createdAt: DateTime.now().toString(),
                      avatar: "",
                      id: "");
                  Navigator.pop(context);
                },
                child: Text("Create")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
                child: Text("Cansal")),
          ],
          content: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameEditText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: numberEditText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Phone Number"),
                  ),
                ),
              ],
            ),
          ),
        );
      });

  newUser = await NetworkService.POST(NetworkService.API_USER, user!.toJson());
  return newUser;
}
