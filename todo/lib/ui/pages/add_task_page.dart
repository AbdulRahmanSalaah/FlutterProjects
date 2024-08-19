import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/theme.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;

  final List<int> _remindList = [5, 10, 15, 20, 25, 30];

  String _selectedRepeat = 'None';

  final List<String> _repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  int _selectedColor = 0;

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _noteController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: customAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'ADD Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          // String formattedTime = picked!.format(context);
                          
                          String formattedTime = DateFormat('hh:mm a').format(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            picked!.hour,
                            picked.minute,
                          ));

                          setState(() {
                            _startTime = formattedTime;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          // String formattedTime = picked!.format(context);
                          String formattedTime = DateFormat('hh:mm a').format(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            picked!.hour,
                            picked.minute,
                          ));
                          setState(() {
                            _endTime = formattedTime;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: _selectedRemind.toString(),
                  items: _remindList
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.toString(),
                          child: Text(
                            '$e',
                            style: const TextStyle(),
                          ),
                        ),
                      )
                      .toList(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: _selectedRepeat,
                  items: _repeatList
                      .map(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(),
                          ),
                        ),
                      )
                      .toList(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPalette(),
                  MyButton(
                    label: '  Add Task',
                    onPressed: () {
                      validate();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar customAppBar() => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        centerTitle: true,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/todolist.png'),
            radius: 20,
          ),
          SizedBox(
            width: 18,
          )
        ],
      );

  Column colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 10),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : null),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        duration: const Duration(milliseconds: 800),
        'required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    } else {
      debugPrint('############ SOMETHING BAD HAPPENED #################');
    }
  }

  void _addTasksToDb() async {
    try {
      //print('here is the selected month ${_selectedDate.month}');
      //print('here is the selected day ${_selectedDate.day}');
      int value = await taskController.addTask(
        task: Task(
        title: _titleController.text.toString(),
        note: _noteController.text.toString(),
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      debugPrint('id value = $value');
    } catch (e) {
      debugPrint('Error = $e');
    }
  }
}
