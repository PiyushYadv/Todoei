import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:todoei/models/todo_task.dart';
import 'package:todoei/theme/todo_theme.dart';
import 'package:uuid/uuid.dart';

class TodoItemScreen extends StatefulWidget {
  const TodoItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalTask,
  }) : isUpdating = (originalTask != null);

  final Function(TodoTask) onCreate;

  final Function(TodoTask) onUpdate;
  final TodoTask? originalTask;
  final bool isUpdating;

  @override
  State<TodoItemScreen> createState() => _TodoItemScreenState();
}

class _TodoItemScreenState extends State<TodoItemScreen> {
  final _nameController = TextEditingController();
  //String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = kCompletedColor;

  @override
  void initState() {
    final originalTask = widget.originalTask;
    if (originalTask != null) {
      _nameController.text = originalTask.name;
      _importance = originalTask.importance;
      _currentColor = originalTask.color;
      final date = originalTask.date;
      _timeOfDay = TimeOfDay(
          hour: originalTask.date.hour, minute: originalTask.date.minute);
      _dueDate = date;

      _nameController.addListener(
        () {
          setState(() {});
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final todoTask = TodoTask(
                id: widget.originalTask?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(todoTask);
              } else {
                widget.onCreate(todoTask);
              }
            },
            icon: Icon(
              Icons.check,
              color: kBackgroundColor,
            ),
          ),
        ],
        title: const Text(
          'Todo Task',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10.0),
            buildColorPicker(context),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Name',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Get groceries, Complete assignment',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              onSelected: (selected) => setState(() {
                _importance = Importance.low;
              }),
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              onSelected: (selected) => setState(() {
                _importance = Importance.medium;
              }),
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              onSelected: (selected) => setState(() {
                _importance = Importance.high;
              }),
            ),
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton(
              child: Text(
                'Select',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kCompletedColor,
                    ),
              ),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(
          DateFormat('yyyy-MM-dd').format(_dueDate),
        ),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton(
              onPressed: () async {
                final timeDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                setState(() {
                  if (timeDay != null) {
                    _timeOfDay = timeDay;
                  }
                });
              },
              child: Text(
                'Select',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kCompletedColor,
                    ),
              ),
            ),
          ],
        ),
        Text(
          _timeOfDay.format(context),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) =>
                        setState(() => _currentColor = color),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'Select',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: kCompletedColor,
                ),
          ),
        ),
      ],
    );
  }
}
