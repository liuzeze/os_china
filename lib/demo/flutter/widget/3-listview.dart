import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('text示例'),
          ),
          body: ListView.builder(
              itemCount: 40,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider();
                }
                return ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text('$index主标题'),
                    subtitle: Text('副标题'),
                    trailing: Icon(Icons.arrow_forward_ios));
              })

        //_buildHorizontalListView()
        //_buildListView(),
      ),
    );
  }

  /**
   * 横向滑动列表
   */
  ListView _buildHorizontalListView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(50, (index) {
        return Text(
          '$index',
          style: TextStyle(fontSize: 30),
        );
      }),
    );
  }

  /**
   * 列表
   */
  ListView _buildListView() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('主标题'),
          subtitle: Text('副标题'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('主标题'),
          subtitle: Text('副标题'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('主标题'),
          subtitle: Text('副标题'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('主标题'),
          subtitle: Text('副标题'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
      ],
    );
  }
}
