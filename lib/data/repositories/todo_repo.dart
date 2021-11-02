import 'package:todos/data/abstract_repo.dart';
import 'package:todos/model/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository implements Repository {
  final dbRef = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> add(String title) async {
    await dbRef.add({
      'title': title,
      'isDone': false,
    });
  }

  @override
  Future<void> changeState(String id) async {
    var temp = await dbRef.doc(id).get();
    bool isDone = temp.get('isDone');

    await dbRef.doc(id).update({
      'isDone': !isDone,
    });
  }

  @override
  Future<List<Todo>> load() async {
    List<Todo> list = [];
    QuerySnapshot<Map<String, dynamic>> temp = await dbRef.get();

    for (var todo in temp.docs){
      list.add(Todo.fromMap(todo.data(), todo.id));
    }

    return list;
  }

  @override
  Future<void> remove(String id) async {
    await dbRef.doc(id).delete();
  }
}
