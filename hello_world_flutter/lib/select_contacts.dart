import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_flutter/create_chat.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _isButtonDisabled = true;
  List<Contact> _selectedContacts;

  @override
  Widget build(BuildContext context) {
    var createChatButton = _buildCreateChatButton();
    var contactList = ContactList();
    contactList.changeNotifier.stream.listen((selectedItems) {
      _selectedContacts = selectedItems;
      _isButtonDisabled = _selectedContacts.length == 0;
      setState(() {});
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          actions: <Widget>[createChatButton],
        ),
        body: contactList);
  }

  FlatButton _buildCreateChatButton() {
    return FlatButton(
      child: Text(
        "create chat",
        style: TextStyle(color: _isButtonDisabled ? Colors.grey : Colors.blue),
      ),
      onPressed: _isButtonDisabled
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return CreateChatPage(_selectedContacts);
                  },
                ),
              );
            },
    );
  }
}

const groups = {'A': kContacts, 'B': aContacts};

const kContacts = const <Contact>[
  const Contact(fullName: 'Albert Hoogmoed', email: 'last seen recently'),
  const Contact(fullName: 'Alena', email: 'last seen within a month')
];

const aContacts = const <Contact>[
  const Contact(fullName: 'Boris Hoogmoed', email: 'last seen within a week'),
  const Contact(fullName: 'Bon Hotel', email: 'last seen within a month')
];

class ContactList extends StatefulWidget {
  final StreamController<List<Contact>> changeNotifier = StreamController();

  @override
  ContactListState createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  List<Contact> _selectedContacts = List<Contact>();

  @override
  Widget build(BuildContext context) {
    return _buildContacts();
  }

  Widget _buildContacts() {
    return ListView.builder(
      itemBuilder: (context, index) => _buildRow(groups.keys.elementAt(index)),
      itemCount: groups.length,
    );
  }

  Widget _buildRow(String key) {
    var groupMemebers = <Widget>[];
    groups[key].forEach((member) {
      var alreadyAdded = _selectedContacts.contains(member);
      var container = Container(
          child: Row(
        children: <Widget>[
          Expanded(
            child: _ContactListItem(member, alreadyAdded, () {
              setState(() {
                if (alreadyAdded) {
                  _selectedContacts.remove(member);
                } else {
                  _selectedContacts.add(member);
                }
                widget.changeNotifier.sink.add(_selectedContacts);
              });
            }),
          )
        ],
      ));
      groupMemebers.add(container);
    });

    return StickyHeader(
      header: Container(
        height: 25.0,
        color: Color.fromARGB(255, 237, 236, 242),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        alignment: Alignment.centerLeft,
        child: Text(
          key,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
      content: Container(
        child: Column(children: groupMemebers),
      ),
    );
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact, selected, onTap)
      : super(
            onTap: onTap,
            title: Text(contact.fullName),
            subtitle: Text(contact.email),
            leading: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Icon(Icons.check_circle,
                    color: selected ? Colors.blue : Colors.grey),
                Container(
                    margin: EdgeInsets.only(left: 30),
                    child: CircleAvatar(child: Text(contact.fullName[0])))
              ],
            ));
}

class Contact {
  final String fullName;
  final String email;

  const Contact({this.fullName, this.email});
}
