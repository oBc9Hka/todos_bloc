class Todo{
  String id;
  String title;
  bool isDone;

  Todo(this.id, this.title, this.isDone);

  Todo.fromMap(Map<String, dynamic> data, String id) : this(
      id,
      data['title'],
      data['isDone'],
  );
}