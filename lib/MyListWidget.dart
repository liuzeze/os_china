import 'package:flutter/material.dart';

class MyListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mylist();
  }
}

class mylist extends State<MyListWidget> {
  List<String> list = List.generate(5, (index) => "条目条目第$index个");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "标题标题标题标题标题标题标题标题标题标题标题标题",
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          maxLines: 2,
        )),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("点击点击")));
        }),
        body: Container(
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(list[index]),
                    background: Container(
                      color: Colors.red,
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (der) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("删除${list[index]}")));
                      list.removeAt(index);
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(list[index]),

                          Image.network(
                            "https://upload-images.jianshu.io/upload_images/1420036-35ac9ea427d62844?imageMogr2/auto-orient/strip%7CimageView2/2/w/280",
                            width: 50,
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
