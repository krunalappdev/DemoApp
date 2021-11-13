import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/02/22/08/41/plastic-4869878_960_720.jpg',
    'https://cdn.pixabay.com/photo/2019/08/05/15/15/template-4386235_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/09/24/01/42/essential-oil-1690887_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/08/14/13/50/botanical-3605609_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/20/17/52/detergent-4865368_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/04/12/03/03/sanitizer-5032551_960_720.png',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Card(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(imageList[index]),
                          Text(
                            "Facial cleanser",
                            textScaleFactor: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Text(
                            "citrus refreshes senses",
                            textScaleFactor: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ))
                    //   FadeInImage.memoryNetwork(
                    //     image: imageList[index],fit: BoxFit.cover, placeholder: kTransparentImage,),
                    // ),
                    ));
          },
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(1, index.isEven ? 2 : 3),
        ),
        color: Colors.grey,
        height: double.infinity,
        width: double.infinity,
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Search Product",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//
