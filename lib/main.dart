import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider7/model/Users.dart';

class UsersProvider extends ChangeNotifier{
  List<Users> _user=[];
  List<Users> get user =>_user;

  Future<void> FetchUser() async{
    final response =  await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      List<dynamic> data = json.decode(response.body);
      var s = data.map((json) => Users.fromJson(json)).toList();
      _user=s;
       notifyListeners();
       
    }
    else {
      throw Exception("failed to load user");
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (context) => UsersProvider(),
      child: MaterialApp(
      home: Home(),
      )
    );
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    userProvider.FetchUser();
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context).size.width,
        child: ListView.builder(
            itemCount: userProvider.user.length,
            itemBuilder: (BuildContext context, int index) {
              final users = userProvider.user[index];
              return ListTile(
                title: Text("${users.name}"),
                subtitle: Text("${users.username}"),
              );
            }
        ),
      ),
    );
  }
}


