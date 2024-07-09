
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/event%20model/event.dart';

class EventService {
  Box<Event>? _eventBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _eventBox = await Hive.openBox<Event>('EVENTBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _eventBox!.close();
  }

  //to add to box
  Future<void> addEvent(Event event) async {
    if (_eventBox == null) {
      await openBox();
    }

    await _eventBox!.put(event.id, event);
  }

  //to get datas from the box
  Future<List<Event>> getEvents() async {
    if (_eventBox == null) {
      await openBox();
    }
    final list = <Event>[];
    for (var i in _eventBox!.values) {
      list.add(i);
    }
  
    return _eventBox!.values.toList();
  }

  //to get data from the box
  Future<Event?> getEvent(int? id) async {
    if (_eventBox == null) {
      await openBox();
    }
    final event = _eventBox!.get(id);
    return event;
  }

  //to update datas in the box
  Future<void> updateEvent(int? id, Event event) async {
    if (_eventBox == null) {
      await openBox();
    }
    if (id != null) {
      await _eventBox!.put(id, event);
    } else {
    }
  }

  //to delete data in the box
  Future<void> deleteEvent(int id) async {
    if (_eventBox == null) {
      await openBox();
    }
    await _eventBox!.delete(id);
  }
}
