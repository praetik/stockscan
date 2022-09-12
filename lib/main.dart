import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stocks/criteria.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Stock Scan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<StockScan>> stockScan;
  @override
  void initState() {
    stockScan = fetchStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Scan"),
      ),
      body: FutureBuilder<List<StockScan>>(
        future: stockScan,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StockScan> scanData = snapshot.data!;
            return ListView.builder(
                itemCount: scanData.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CriteriaPage(
                                  name: scanData[index].name.toString(),
                                  tag: scanData[index].tag.toString(),
                                  color: scanData[index].color.toString(),
                                  criteria: scanData[index].criteria)));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scanData[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(scanData[index].tag,
                              style: TextStyle(
                                color: scanData[index].color == 'green'
                                    ? Colors.green
                                    : Colors.red,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<List<StockScan>> fetchStocks() async {
  final response = await http
      .get(Uri.parse("https://mobile-app-challenge.herokuapp.com/data"));
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((e) => StockScan.fromJson(e)).toList();
  } else {
    throw Exception("Unexpected error occured");
  }
}

class StockScan {
  final int id;
  final String name;
  final String tag;
  final String color;
  List<dynamic> criteria;
  StockScan(
      {required this.id,
      required this.name,
      required this.tag,
      required this.color,
      required this.criteria});

  factory StockScan.fromJson(Map<String, dynamic> json) {
    return StockScan(
        id: json['id'],
        name: json['name'],
        tag: json['tag'],
        color: json['color'],
        criteria: json['criteria']);
  }
}
