import 'package:todos/data/abstract_repo.dart';
import 'package:todos/model/todo.dart';

class DummyRepository extends Repository {
  final List<Todo> _list = [
    Todo('1', 'колбаса', false),
    Todo('2', 'батон', false),
  ];

  @override
  Future<void> add(String title) async {
    _list.add(Todo((_list.length + 1).toString(), title, false));
  }

  @override
  Future<void> changeState(String id) async {
    for(var todo in _list){
      if(todo.id == id){
        todo.isDone = !todo.isDone;
      }
    }
  }

  @override
  Future<List<Todo>> load() async {
    return _list;
  }

  @override
  Future<void> remove(String id) async {
    var forRemove;

    for(var todo in _list){
      if(todo.id == id){
        forRemove = todo;
      }
    }

    if(forRemove != null) {
      _list.remove(forRemove);
    }
  }
}
