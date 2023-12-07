import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      required this.editFunction}
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: const Color.fromARGB(255, 166, 196, 194),
              borderRadius: BorderRadius.circular(10),
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_forever,
              backgroundColor: const Color.fromARGB(255, 253, 106, 106),
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 117, 226, 197),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // галочка
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              // список дел
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 17.0,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                          decorationThickness: 2.0,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
