import 'package:flutter/material.dart';
import 'package:todos/bloc/bloc.dart';
import 'package:todos/model/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({Key? key, required this.todo, required this.bloc})
      : super(key: key);
  final Todo todo;
  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.cancel),
              Text('Убрать')
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        bloc.event.add(RemoveTodo(todo.id));
      },
      child: CheckboxListTile(
        value: todo.isDone,
        onChanged: (bool? value) {
          bloc.event.add(CheckTodo(todo.id));
        },
        title: Text(todo.title),
      ),
    );
  }
}
