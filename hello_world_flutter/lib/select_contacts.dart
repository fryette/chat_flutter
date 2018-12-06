import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_flutter/blocs/block_provider.dart';
import 'package:hello_world_flutter/blocs/selected_bloc.dart';
import 'package:hello_world_flutter/create_chat.dart';
import 'package:hello_world_flutter/models/contact.dart';
import 'package:hello_world_flutter/widgets/contact_card_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactsPage extends StatelessWidget {
  final List<Contact> _selectedContacts = List();

  @override
  Widget build(BuildContext context) {
    final ContactsBloc contactsBloc = BlocProvider.of<ContactsBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          actions: <Widget>[_buildCreateChatButton(contactsBloc)],
        ),
        body: _buildContacts(contactsBloc));
  }

  Widget _buildCreateChatButton(ContactsBloc contacts) {
    return StreamBuilder<int>(
        stream: contacts.outTotalFavorites,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return FlatButton(
              child: Text(
                "create chat",
                style: TextStyle(color: snapshot.data == 0 ? Colors.grey : Colors.blue),
              ),
              onPressed: snapshot.data == 0
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
                        return CreateChatPage(_selectedContacts);
                      }));
                    });
        });
  }

  Widget _buildContacts(ContactsBloc bloc) {
    return ListView.builder(
      itemBuilder: (context, index) => _buildRow(groups.keys.elementAt(index), bloc),
      itemCount: groups.length,
    );
  }

  Widget _buildRow(String key, ContactsBloc bloc) {
    var groupMemebers = <Widget>[];
    groups[key].forEach((member) {
      var container = Container(
          child: Row(
        children: <Widget>[
          Expanded(child: ContactCardWidget(contactCard: member, selectedContactsStream: bloc.outContacts))
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
          child: Text(key, style: const TextStyle(color: Colors.grey))),
      content: Container(child: Column(children: groupMemebers)),
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
