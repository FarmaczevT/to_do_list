import 'package:flutter/material.dart';
import 'package:to_do_list/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controler;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, this.controler, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      content: Container(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // поле ввода
            TextField(
              controller: controler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Добавить новую задачу",
              ),
            ),
            // кнопка сохранить и отменить
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // кнопка сохранить
                MyButton(text: "Сохранить", onPressed: onSave),
                const SizedBox(width: 20),
                // кнопка отменить
                MyButton(text: "Отменить", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
