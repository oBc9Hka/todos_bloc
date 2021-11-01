import 'package:todos/data/abstract_repo.dart';
import 'package:todos/model/todo.dart';

class TodoRepository implements Repository{
  @override
  Future<void> add(String title) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> changeState(String id) {
    // TODO: implement changeState
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> load() {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }


}