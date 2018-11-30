import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateChatPage extends StatefulWidget {
  @override
  _CreateChatPageState createState() => new _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Create'),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 25,
                ),
                color: Colors.cyan,
                onPressed: () {}),
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return new ListView.builder(
        padding: const EdgeInsets.only(top: 16.0),
        itemCount: 10,
        itemBuilder: (BuildContext _context, int i) {
          return _buildChatListRow(i);
        });
  }

  Widget _buildTopContent() {
    return new Container(
        color: Color.fromARGB(255, 237, 236, 242),
        child: new Column(children: <Widget>[
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16, top: 20),
              child: new Row(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://t3.ftcdn.net/jpg/01/13/41/66/500_F_113416666_a7CuS6cvc6D5P5ezUbsTMexJHm9iAgga.jpg'),
                      backgroundColor: Colors.grey,
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                  ),
                  new Flexible(
                    child: new Container(
                      child: new TextField(
                        decoration: new InputDecoration.collapsed(
                          hintText: 'Group Name',
                        ),
                        onChanged: (s) {
                          //setState(() => validateName(s));
                        },
                      ),
                      decoration: new BoxDecoration(
                        border: new Border(
                          bottom: new BorderSide(
                              color: Theme.of(context).dividerColor,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 1,
                ),
                new SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                        padding: EdgeInsets.only(left: 16),
                        onPressed: () => {},
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Change group photo",
                              style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 16,
                              ),
                            )))),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 16),
            child: Text(
              '0 members',
              style: TextStyle(color: Colors.grey),
            ),
            alignment: Alignment.topLeft,
          ),
        ]));
  }

  Widget _buildChatListRow(int i) {
    if (i == 0) {
      return _buildTopContent();
    }
    return Container(
        padding: EdgeInsets.only(left: 16),
        color: Colors.white,
        child: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Container(
              padding: EdgeInsets.all(0),
              child: CircleAvatar(radius: 20, child: Text('AH')),
            ),
            title: Column(children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  child: Text("Aliaksandr Bringless",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ]),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text("last seen recently",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal)),
              )
            ])));
  }
}
