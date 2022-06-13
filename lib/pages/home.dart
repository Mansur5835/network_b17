import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_network/models/user_model.dart';
import 'package:flutter_network/services/network_service.dart';
import 'package:flutter_network/view/update_dialog.dart';

import '../view/create_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User>? listOfUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initList();
  }

  initList() async {
    setState(() {
      listOfUser = null;
    });
    String? response =
        await NetworkService.GET(NetworkService.API_USER, {"asd": ""});
    if (response == null) {
      return;
    }
    List<dynamic> list = jsonDecode(response);

    listOfUser = List.generate(list.length, (index) {
      return User.fromJson(list[index]);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfUser == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {},
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: List.generate(listOfUser!.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      subtitle: Text(listOfUser![index].phoneNumber!),
                      title: Text(listOfUser![index].name!),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            onPressed: () async {
                              String? asdf = await updateDialogShow(
                                  context, listOfUser![index]);

                              initList();
                            },
                            icon: Icon(Icons.mode)),
                        SizedBox(
                          height: 10,
                        ),
                        IconButton(
                            onPressed: () async {
                              await NetworkService.DELETE(
                                  NetworkService.API_USER_DELETE +
                                      listOfUser![index].id.toString(),
                                  {"asdf": "fasdf"});
                              initList();
                            },
                            icon: Icon(Icons.delete)),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                  );
                }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          setState(() {
            listOfUser = null;
          });
          String? asdf = await createDialogShow(context);

          initList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
