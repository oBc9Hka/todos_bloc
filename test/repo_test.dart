import 'package:flutter_test/flutter_test.dart';
import 'package:todos/bloc/bloc.dart';
import 'package:todos/data/repositories/dummy_repo.dart';

void main(){
  group('Todos repo tests', (){
    test('Load todos', () async {
      final Bloc bloc = Bloc(DummyRepository());

      bloc.event.add(LoadTodo());
      expect(bloc.todos.length, 2);
    });
  });
}