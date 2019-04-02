import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: DismissibleWidget(),
    ));

class DismissibleWidget extends StatefulWidget {
  @override
  _DismissibleWidgetState createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  List<String> items = List.generate(20, (index) {
    return '条目$index';
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          var item = items[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
              onDismissed: (_) {
                items.removeAt(index);
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key('$item'),
              child: ListTile(
                title: Text('$item'),
              ));
        },
        itemCount: items.length,
      ),
    );
  }
}
