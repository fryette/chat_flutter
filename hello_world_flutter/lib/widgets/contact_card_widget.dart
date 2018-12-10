import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world_flutter/blocs/block_provider.dart';
import 'package:hello_world_flutter/blocs/contacts_bloc.dart';
import 'package:hello_world_flutter/blocs/contact_bloc.dart';
import 'package:hello_world_flutter/models/contact.dart';

class ContactCardWidget extends StatefulWidget {
  ContactCardWidget({Key key, @required this.contactCard, @required this.selectedContactsStream})
      : super(key: key);

  final Contact contactCard;
  final Stream<List<Contact>> selectedContactsStream;

  @override
  State<StatefulWidget> createState() => ContactCardWidgetState();
}

class ContactCardWidgetState extends State<ContactCardWidget> {
  StreamSubscription _subscription;
  ContactBloc _selectedContactsBloc;

  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  @override
  void didUpdateWidget(ContactCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _createBloc() {
    _selectedContactsBloc = ContactBloc(widget.contactCard);

    _subscription = widget.selectedContactsStream.listen(_selectedContactsBloc.inSelected.add);
  }

  void _disposeBloc() {
    _subscription.cancel();
    _selectedContactsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ContactsBloc bloc = BlocProvider.of<ContactsBloc>(context);
    return ListTile(
        onTap: () {
          if (_isSelected) {
            bloc.inRemoveContact.add(widget.contactCard);
          } else {
            bloc.inAddContact.add(widget.contactCard);
          }
        },
        title: Text(widget.contactCard.fullName),
        subtitle: Text(widget.contactCard.email),
        leading: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            StreamBuilder<bool>(
              stream: _selectedContactsBloc.outIsSelected,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                _isSelected = snapshot.data;
                return Icon(Icons.check_circle, color: snapshot.data ? Colors.blue : Colors.grey);
              },
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                child: CircleAvatar(child: Text(widget.contactCard.fullName[0])))
          ],
        ));
  }
}
