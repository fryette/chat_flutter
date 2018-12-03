import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    var p = new ContactList(kContacts);

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contacts"),
          actions: <Widget>[_buildCreateChatButton()],
        ),
        body: new ContactList(kContacts));
  }

  Widget _buildCreateChatButton() {
    return new IconButton(
      icon: const Icon(
        Icons.add,
        size: 25,
      ),
      color: Colors.cyan,
      onPressed: _isButtonDisabled ? null : () {},
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
  final List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  ContactListState createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  List<Contact> selectedContacts = List<Contact>();

  @override
  Widget build(BuildContext context) {
    return _buildContacts();
  }

  Widget _buildContacts() {
    return ListView.builder(
      itemBuilder: (context, index) => _buildRow(groups.keys.elementAt(index)),
      itemCount: widget._contacts.length,
    );
  }

  Widget _buildRow(String key) {
    var groupMemebers = <Widget>[];
    groups[key].forEach((member) {
      var alreadyAdded = selectedContacts.contains(member);
      var container = Container(
          child: Row(
        children: <Widget>[
          Expanded(
            child: _ContactListItem(member, alreadyAdded, () {
              setState(() {
                if (alreadyAdded) {
                  selectedContacts.remove(member);
                } else {
                  selectedContacts.add(member);
                }
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
