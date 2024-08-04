import 'package:flutter/material.dart';
import 'package:galaxy_planets/Model/Favourite.dart';

class favouritePage extends StatefulWidget {
  const favouritePage({super.key});

  @override
  State<favouritePage> createState() => _favouritePageState();
}

class _favouritePageState extends State<favouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Page",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          ...favourite.favGitaData.map((e) => Padding(
                padding: EdgeInsets.only(right: 12, left: 12, top: 12),
                child: Card(
                  elevation: 4,
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${e['position']}",
                                style: TextStyle(fontSize: 22),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${e['name']}",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    favourite.favData.remove(e);
                                    favourite.favGitaData.remove(e);
                                    e['like'] != e['like'];
                                  });
                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
