import 'package:flutter/material.dart';

void main() => runApp(new CardWidget());

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "card",
      home: CardHomeWidget(),
    );
  }
}

class CardHomeWidget extends StatefulWidget {
  @override
  _CardHomeWidgetState createState() => _CardHomeWidgetState();
}

class _CardHomeWidgetState extends State<CardHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cardview'),
      ),
      body: ListView(
        children: <Widget>[
          buildCard(),
          buildCard(),
          buildCard(),
          buildCard(),
        ],
      ),
    );
  }

  Card buildCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(
                    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.contact_mail),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "周末去哪儿",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '草原好风景',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Color(0xffff0000),
                    ),
                    Text("150赞"),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
