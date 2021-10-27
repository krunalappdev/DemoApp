
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RandomState();
  }
}

class RandomState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return MaterialApp(
    //   title: 'Welcome to Flutter',
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Welcome to Flutter'),
    //     ),
    //     body: Center(                       // Drop the const, and
    //       //child: Text('Hello World'),     // Replace this text...
    //       child: Text(wordPair.asPascalCase),  // With this text.
    //     ),
    //   ),
    // );;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}