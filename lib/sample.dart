import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixed Top in Flutter'),
      ),
      body: Stack(
        children: [
          // First child is the fixed widget
          Container(
            color: Colors.blue,
            height: 100, // Adjust the height as needed
            child: Center(
              child: Text(
                'Fixed Top Widget',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Second child is the scrollable content
          ListView.builder(
            itemCount: 50, // Replace with your actual content
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ],
      ),
    );
  }
}
