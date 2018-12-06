import 'dart:async';
import 'dart:collection';

import 'package:hello_world_flutter/blocs/block_provider.dart';
import 'package:hello_world_flutter/models/contact.dart';
import 'package:rxdart/rxdart.dart';

class ContactsBloc implements BlocBase {
  ///
  /// Unique list of all favorite movies
  ///
  final Set<Contact> _selectedContacts = Set<Contact>();

  // ##########  STREAMS  ##############
  ///
  /// Interface that allows to add a new contact to chat
  ///
  BehaviorSubject<Contact> _selectedContactsAddController = new BehaviorSubject<Contact>();
  Sink<Contact> get inAddContact => _selectedContactsAddController.sink;

  ///
  /// Interface that allows to remove a movie from the list of favorites
  ///
  BehaviorSubject<Contact> _selectedContactsRemoveController = new BehaviorSubject<Contact>();
  Sink<Contact> get inRemoveContact => _selectedContactsRemoveController.sink;

  ///
  /// Interface that allows to get the total number of favorites
  ///
  BehaviorSubject<int> _selectedContactsTotalController = new BehaviorSubject<int>(seedValue: 0);
  Sink<int> get _inTotalFavorites => _selectedContactsTotalController.sink;
  Stream<int> get outTotalFavorites => _selectedContactsTotalController.stream;

  ///
  /// Interface that allows to get the list of all favorite movies
  ///
  BehaviorSubject<List<Contact>> _selectedController = new BehaviorSubject<List<Contact>>(seedValue: []);
  Sink<List<Contact>> get _inContacts => _selectedController.sink;
  Stream<List<Contact>> get outContacts => _selectedController.stream;

  ///
  /// Constructor
  ///
  ContactsBloc() {
    _selectedContactsAddController.listen(_handleAddContact);
    _selectedContactsRemoveController.listen(_handleRemoveContact);
  }

  void dispose() {
    _selectedContactsAddController.close();
    _selectedContactsRemoveController.close();
    _selectedContactsTotalController.close();
    _selectedController.close();
  }

  // ############# HANDLING  #####################

  void _handleAddContact(Contact contactCard) {
    _selectedContacts.add(contactCard);

    _notify();
  }

  void _handleRemoveContact(Contact contactCard) {
    _selectedContacts.remove(contactCard);

    _notify();
  }

  void _notify() {
    // Send to whomever is interested...
    // The total number of favorites
    _inTotalFavorites.add(_selectedContacts.length);

    // The new list of all favorite movies
    _inContacts.add(UnmodifiableListView(_selectedContacts));
  }
}
