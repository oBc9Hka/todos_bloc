import 'package:todos/model/todo.dart';

abstract class Repository {
  Future<List<Todo>> load();

  Future<void> add(String title);

  Future<void> changeState(String id);

  Future<void> remove(String id);
}
