import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planets/Model/Favourite.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late Animation sizeAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
      lowerBound: 0,
      upperBound: 1,
    );

    sizeAnimation =
        Tween<double>(begin: 200, end: 300).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Page",
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                data['isTapped'] = !data['isTapped'];
                if (data['isTapped']) {
                  favourite.favData.add(data);
                } else {
                  favourite.favData.remove(data);
                }
                favourite.convertUniqueData();
              });
            },
            icon: Icon(
              data['isTapped']
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: data['isTapped'] ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Text(
                      "${data['position']}",
                      style: TextStyle(
                        fontSize: 200,
                        color: Colors.grey.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TweenAnimationBuilder(
                              tween: Tween<double>(
                                begin: 0,
                                end: 80,
                              ),
                              duration: Duration(seconds: 2),
                              builder: (context, double position, _) {
                                return Transform.translate(
                                  offset: Offset(0, position),
                                  child: TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0, end: 2 * pi),
                                    duration: Duration(seconds: 2),
                                    builder: (context, double degree, _) {
                                      return Transform.rotate(
                                        angle: degree,
                                        child: Image.network(
                                          data['image'],
                                          height: sizeAnimation.value,
                                          width: sizeAnimation.value,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              })
                        ],
                      ),
                      SizedBox(height: 150),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              animationController.forward();
                            },
                            child: Text("Forward"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              animationController.reverse();
                            },
                            child: Text("Reverse"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              animationController.repeat();
                            },
                            child: Text("Repeat"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Solar System",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    data['description'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Gallery",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Image.network(
                      data['image'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Image.network(
                      data['image'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
