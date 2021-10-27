import 'dart:convert';

import 'package:auth/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class listing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return listingState();
  }
}

class listingState extends State<listing> {
  // late Future<User> futureAlbum;
  bool isLoading = false;

  late List<String> results = <String>[];

  int page = 1;
  int total = 0;

 fetchAlbum() async {
    final response = await http.get(Uri.parse(
        'https://swapi.dev/api/planets/?format=json&page=' + page.toString()));
    isLoading = false;
    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      var json = jsonDecode(response.body);
      total =  json['count'];
      json['results'].forEach((v) {
        setState(() {
          var v2 = v;
          results.add(v2['name']);
        });

        // print(v2['name']);
      });
      // return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
   fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    Future _loadData() async {
      // perform fetching data delay

      await new Future.delayed(new Duration(seconds: 1));
      // update data and loading status
        setState(() {
          page += 1;
          fetchAlbum();
          isLoading = false;
        });


    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  if(results.length != total) {
                    _loadData();
                    // start loading data
                    setState(() {
                      isLoading = true;
                    });
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${results[index]}'),
                  );
                },
              ),
            ),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

    // return FutureBuilder<User>(
    //   future: futureAlbum,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text("Hello"),
    //         ),
    //         body: Column(
    //           children: <Widget>[
    //             Expanded(
    //               child: NotificationListener<ScrollNotification>(
    //                 onNotification: (ScrollNotification scrollInfo) {
    //                   if (!isLoading &&
    //                       scrollInfo.metrics.pixels ==
    //                           scrollInfo.metrics.maxScrollExtent) {
    //                     _loadData();
    //                     // start loading data
    //                     setState(() {
    //                       isLoading = true;
    //                     });
    //                   }
    //                   return false;
    //                 },
    //                 child: ListView.builder(
    //                   itemCount: snapshot.data!.results.length,
    //                   itemBuilder: (context, index) {
    //                     return ListTile(
    //                       title: Text('${snapshot.data!.results[index].name}'),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               height: isLoading ? 50.0 : 0,
    //               color: Colors.transparent,
    //               child: Center(
    //                 child: new CircularProgressIndicator(),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Text('${snapshot.error}');
    //     }
    //
    //     // By default, show a loading spinner.
    //     return const CircularProgressIndicator();
    //   },
    // );
  }
}
