import 'dart:convert' show jsonDecode;
import 'dart:math';
import 'package:api_rest_mysql_pasteleria/model/bd_pastel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApi extends StatefulWidget {
  const MyApi({super.key});

  @override
  State<MyApi> createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {
  // final url = Uri.parse(
  //     "https://restapilogin-production.up.railway.app/api/pasteria&daniel&el&travieso/pastel");
  late Future<List<PastelDb>> user;
  final name = TextEditingController();
  final sabor = TextEditingController();
  @override
  void initState() {
    super.initState();
    user = getPastelDb();
    // getPastelDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API de la Pastelería'),
      ),
      body: FutureBuilder<List<PastelDb>>(
        future: user,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int name) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(snapshot.data![name].name.toString() +
                          " " +
                          snapshot.data![name].sabor.toString()),
                      subtitle: Text(
                          "${snapshot.data![name].color} ${snapshot.data![name].dibujo}"),
                    ),
                    const Divider()
                  ],
                );

                //? Example
                // "${snapshot.data![name].name} ${snapshot.data![name].sabor}");
              },
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return const CircularProgressIndicator();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showForm,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void showForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Agregar Usuario"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  //? El KeyboardType sirve para usarlo como gmail y usar el aroba
                  ////! @
                  // keyboardType: TextInputType.emailAddress,
                  controller: sabor,
                  decoration: const InputDecoration(hintText: "Sabor"),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Guardar"),
              )
            ],
          );
        });
  }

  //? Video example

// Future<List<PastelDb>> getPastelDb() async {
//   final res = await http.get(url);
//   final jsonBody = List.from(jsonDecode(res.body));

//   List<PastelDb> userTwo = [];
//   jsonBody.forEach((element) {
//     final PastelDb user1 = PastelDb.fromJson(element);
//   });
//   return userTwo;
// }
}

Future<List<PastelDb>> getPastelDb() async {
  final res = await http.get(Uri.parse(
      "https://restapilogin-production.up.railway.app/api/pasteria&daniel&el&travieso/pastel"));
  final list = List.from(jsonDecode(res.body));

  List<PastelDb> user = [];
  for (var element in list) {
    final PastelDb admin = PastelDb.fromJson(element);
    user.add(admin);
  }
  return user;
}

//* Example Two
// Future<List<PastelDb>> getPastelDb1() async {
//   final res = await http.get(Uri.parse(
//       "https://restapilogin-production.up.railway.app/api/pasteria&daniel&el&travieso/pastel"));
//   final list = List.from(jsonDecode(res.body));

//   List<PastelDb> userTwo = [];
//   list.forEach((element) {
//     final PastelDb adminOne = PastelDb.fromJson(element);
//     userTwo.add(adminOne);
//   });

//   return userTwo;
// }
