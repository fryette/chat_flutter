import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello_world_flutter/SignalRClient.dart';
import 'package:hello_world_flutter/select_contacts.dart';
import 'package:hello_world_flutter/widgets/circleImage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final SignalRClient _client = SignalRClient();
  @override
  Widget build(BuildContext context) {
    _test();
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }

  Future _test() async {
    await _client.connect('http://10.55.1.191:51001/IntegrationTestHub', '');
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Chats'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(
                Icons.add,
                size: 25,
              ),
              color: Colors.cyan,
              onPressed: getNextPage),
        ],
      ),
      body: new Stack(children: <Widget>[
        _buildSuggestions(),
        new Container(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            tooltip: 'Toggle',
            child: Icon(
              Icons.add,
              color: Colors.grey,
            ),
            onPressed: getNextPage,
          ),
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(right: 20, bottom: 40),
        )
      ]),
    );
  }

  void getNextPage() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new ContactsPage();
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider(
              indent: 100,
            );
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length - 100) {
            _suggestions.addAll(generateWordPairs().take(100));
          }
          return _buildChatListRow();
        });
  }

  Widget _buildChatListRow() {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          child: CircleImage(50),
        ),
        title: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Text(
                  "My Nigazih wejfiuoew hoi ufgheo uwihfiu dwh ouihwo iufho qwieå channel",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            Container(
                margin: const EdgeInsets.only(left: 5),
                alignment: Alignment.topRight,
                child: Text("18:48",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14)))
          ]),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text("Hello my friend",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal)),
          )
        ]));
  }
}
