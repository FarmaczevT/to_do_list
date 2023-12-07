import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/util/dialog_box.dart';
import 'package:to_do_list/util/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // текст контролер
  final _controler = TextEditingController();

  // чекбокс
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Сохранение новой задачи и проверка заполнения
  void saveNewTask() {
    if (_controler.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controler.text, false]);
        _controler.clear();
      });
      db.updateDataBase();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, заполните поле ввода'),
        ),
      );
    }
  }

  // Создание новой задачи
  void createNewTask() {
    _controler.clear();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controler: _controler,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Удаление задачи
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // Редактирование
  void editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        _controler.text = db.toDoList[index][0];
        return DialogBox(
          controler: _controler,
          onSave: () {
            if (_controler.text.isNotEmpty) {
              setState(() {
                db.toDoList[index][0] = _controler.text;
                _controler.clear();
              });
              db.updateDataBase();
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Пожалуйста, заполните поле ввода'),
                ),
              );
            }
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? const Center(
              child: Text(
                'Ваш список дел пуст',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length, // определяет количество элементов в списке
              itemBuilder: (context, index) {
                // определяет, какой виджет будет отображаться для каждого элемента списка
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  editFunction: (context) => editTask(index),
                );
              },
            ),
    );
  }
}
