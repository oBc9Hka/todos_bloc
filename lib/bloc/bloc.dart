import 'dart:async';

import 'package:todos/data/abstract_repo.dart';
import 'package:todos/model/todo.dart';

class Events {}

class AddTodo extends Events {
  final String title;

  AddTodo(this.title);
}

class LoadTodo extends Events {}

class RemoveTodo extends Events {
  final String id;

  RemoveTodo(this.id);
}

class CheckTodo extends Events {
  final String id;

  CheckTodo(this.id);
}

class Bloc {
  final Repository _repository;

  List<Todo> todos = [];

  final _stateController = StreamController<List<Todo>>();
  final _eventsController = StreamController<Events>();

  Stream<List<Todo>> get state => _stateController.stream;

  Sink<Events> get event => _eventsController.sink;

  Bloc(this._repository) {
    _eventsController.stream.listen(_handleEvent);
  }

  void dispose() {
    _stateController.close();
    _eventsController.close();
  }

  void _handleEvent(Events event) async {
    if (event is LoadTodo) {
      todos = await _repository.load();
    } else if (event is AddTodo) {
      await _repository.add(event.title);
    } else if (event is CheckTodo) {
      await _repository.changeState(event.id);
    } else if (event is RemoveTodo) {
      await _repository.remove(event.id);
    }
    _stateController.add(todos);
  }
}
