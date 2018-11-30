import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contacts"),
        ),
        body: new ContactList(kContacts));
  }
}

const groups = {'a': kContacts, 'b': aContacts};

const kContacts = const <Contact>[
  const Contact(fullName: 'Albert Hoogmoed', email: 'last seen recently'),
  const Contact(fullName: 'Alena', email: 'last seen within a month')
];

const aContacts = const <Contact>[
  const Contact(fullName: 'Boris Hoogmoed', email: 'last seen within a week'),
  const Contact(fullName: 'Bon Hotel', email: 'last seen within a month')
];

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;
  List<Contact> _selectedContacts = List<Contact>();
  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        var groupMemebers = <Widget>[];
        var key = groups.keys.elementAt(index);
        groups[key].forEach((member) {
          var alreadyAdded = _selectedContacts.contains(index);
          var container = Container(
              child: new Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: alreadyAdded
                      ? Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.blue,
                        )
                      : Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                          width: 20.0,
                          height: 20.0,
                          padding: const EdgeInsets.all(1.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ))),
              Expanded(
                child: _ContactListItem(member, () {
                  if (alreadyAdded) {
                    _selectedContacts.remove(member);
                  } else {
                    _selectedContacts.add(member);
                  }
                }),
              )
            ],
          ));
          groupMemebers.add(container);
        });

        var content = new StickyHeader(
          header: new Container(
            height: 50.0,
            color: Color.fromARGB(255, 237, 236, 242),
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              key,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          content: new Container(
            child: Column(children: groupMemebers),
          ),
        );

        return content;
      },
      itemCount: _contacts.length,
    );
  }
}

class _ContactListItem extends StatefulWidget {
  bool selected = false;
  Function onTap;
  Contact contact;

  _ContactListItem(Key key, Contact contact, onTap);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: onTap,
        title: new Text(contact.fullName),
        subtitle: new Text(contact.email),
        leading: new Row(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: selected
                  ? Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.blue,
                    )
                  : Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      width: 20.0,
                      height: 20.0,
                      padding: const EdgeInsets.all(1.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ))),
          CircleAvatar(child: new Text(contact.fullName[0]))
        ]));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _ContactListItemState extends State<_ContactListItem> {
  final Set<Contact> _saved = new Set<Contact>(); // Add this line.
  final List<Contact> _selectedContacts = List<Contact>();

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        var groupMemebers = <Widget>[];
        var key = groups.keys.elementAt(index);
        groups[key].forEach((member) {
          var alreadyAdded = _selectedContacts.contains(index);
          var container = Container(
              child: new Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: alreadyAdded
                      ? Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.blue,
                        )
                      : Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                          width: 20.0,
                          height: 20.0,
                          padding: const EdgeInsets.all(1.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ))),
              Expanded(
                child: _ContactListItem(member, () {
                  if (alreadyAdded) {
                    _selectedContacts.remove(member);
                  } else {
                    _selectedContacts.add(member);
                  }
                }),
              )
            ],
          ));
          groupMemebers.add(container);
        });

        var content = new StickyHeader(
          header: new Container(
            height: 50.0,
            color: Color.fromARGB(255, 237, 236, 242),
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              key,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          content: new Container(
            child: Column(children: groupMemebers),
          ),
        );

        return content;
      },
      itemCount: _contacts.length,
    );
  }

  Widget _buildRow(Contact contact) {
    final bool alreadySaved = _saved.contains(contact);
    return new ListTile(
        onTap: () {},
        title: new Text(contact.fullName),
        subtitle: new Text(contact.email),
        leading: new Row(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: alreadySaved
                  ? Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.blue,
                    )
                  : Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      width: 20.0,
                      height: 20.0,
                      padding: const EdgeInsets.all(1.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ))),
          CircleAvatar(child: new Text(contact.fullName[0]))
        ]));
  }
}

class Contact {
  final String fullName;
  final String email;

  const Contact({this.fullName, this.email});
}
