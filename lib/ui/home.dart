import 'package:flutter/material.dart';
import 'package:todos/bloc/bloc.dart';
import 'package:todos/data/repositories/dummy_repo.dart';
import 'package:todos/data/repositories/todo_repo.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/ui/widgets/app_bar.dart';
import 'package:todos/ui/widgets/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Bloc bloc;
  final TextEditingController _createTodoTextController =
      TextEditingController();

  @override
  void initState() {
    // bloc = Bloc(DummyRepository());
    bloc = Bloc(TodoRepository());
    bloc.event.add(LoadTodo());
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bloc: bloc,
        createTodoTextController: _createTodoTextController,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.event.add(LoadTodo());
        },
        child: StreamBuilder<List<Todo>>(
          stream: bloc.state,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                bloc.event.add(LoadTodo());
                return ListView(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.8),
                      child: const Center(child: Text('Список пуст')),
                    ),
                  ],
                );
              }
              return ListView(
                children: [
                  ...snapshot.data!.map(
                    (todo) => TodoTile(todo: todo, bloc: bloc),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Список пуст'));
            }
          },
        ),
      ),
    );
  }
}
