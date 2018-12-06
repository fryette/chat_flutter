import 'dart:async';

import 'package:hello_world_flutter/blocs/block_provider.dart';
import 'package:hello_world_flutter/models/contact.dart';
import 'package:rxdart/rxdart.dart';

class SelectedContactsBloc implements BlocBase {
  final BehaviorSubject<bool> isSelectedController = BehaviorSubject<bool>();
  Stream<bool> get outIsSelected => isSelectedController.stream;

  final StreamController<List<Contact>> _selectedController = StreamController<List<Contact>>();
  Sink<List<Contact>> get inSelected => _selectedController.sink;

  SelectedContactsBloc(Contact contact) {
    _selectedController.stream
        .map((list) => list.any((Contact item) => item.fullName == contact.fullName))
        .listen((isSelected) => isSelectedController.add(isSelected));
  }

  @override
  void dispose() {
    _selectedController.close();
    isSelectedController.close();
  }
}
