import 'package:flutter/material.dart';
import 'package:todos/bloc/bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Bloc bloc;
  final TextEditingController createTodoTextController;

  const CustomAppBar({
    Key? key,
    required this.createTodoTextController,
    required this.bloc,
  }) : super(key: key);

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: createTodoTextController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Добавить в список',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (createTodoTextController.text.trim() != '') {
              bloc.event.add(AddTodo(createTodoTextController.text));
            }
            createTodoTextController.clear();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: const Text(
            'Добавить',
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: _title(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
