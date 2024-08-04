import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planets/Provider/ThemeProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> jsonData;

  void loadjson() {
    jsonData = rootBundle.loadString("assets/JSON/data.json");
  }

  @override
  void initState() {
    super.initState();
    loadjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
        ),
        actions: [
          Switch(
            value: Provider.of<ThemeProvider>(context).istap,
            onChanged: (val) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .changetheme(val);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                'favouritePage',
              );
            },
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: jsonData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}",
                  style: TextStyle(color: Colors.red, fontSize: 18)),
            );
          } else if (snapshot.hasData) {
            String? data = snapshot.data;
            List<dynamic> allData = (data == null) ? [] : jsonDecode(data);

            if (data == null) {
              return Center(
                child: Text(
                  "No Data Available...",
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 250,
                ),
                itemCount: allData.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('detailPage', arguments: allData[i]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(9),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                allData[i]['image'],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${allData[i]['name']}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
