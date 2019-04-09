import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: ReorderWidget(),
    ));

class ReorderWidget extends StatefulWidget {
  @override
  _ReorderWidgetState createState() => _ReorderWidgetState();
}

class _ReorderWidgetState extends State<ReorderWidget> {
  List<String> listitem = List.generate(8, (index) => '条目$index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖拽列表'),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex == listitem.length) {
            newIndex = listitem.length - 1;
          }
          var element = listitem.removeAt(oldIndex);
          listitem.insert(newIndex, element);
          setState(() {});
        },
        children: listitem
            .map((m) => ListTile(
                  subtitle: Text('123456'),
                  key: ObjectKey(m),
                  leading: Icon(Icons.contact_mail),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text('$m'),
                  isThreeLine: true,
                  selected: false,
                  onTap: () {},
                ))
            .toList(),
      ),
    );
  }
}
