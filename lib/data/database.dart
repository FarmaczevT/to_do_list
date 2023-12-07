import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Свайпни влево, чтобы редактировать или удалить", false],
      ["Добавь новую задачу, нажав на кнопку в правом нижнем углу", false],
      ["Отметь галочкой если выполнил задание", true],
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
