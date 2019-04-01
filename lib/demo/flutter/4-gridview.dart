import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('GRIDVIEW'),
          ),
          body: GridView.builder(
            itemCount: 50,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,crossAxisSpacing: 6, mainAxisSpacing: 6),
              itemBuilder: (context, index) {
                return Container(
                    color: Colors.red,
                    child: Text('$index条目'));
              }) //buildGridViewCount(),
          ),
    );
  }

  GridView buildGridViewCount() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3 / 4,
      scrollDirection: Axis.vertical,
      children: List.generate(50, (index) {
        return Container(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: Text('$index条目'));
      }),
    );
  }
}
