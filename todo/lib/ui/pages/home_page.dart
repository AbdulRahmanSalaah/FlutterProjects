import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';

import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifayHelper;

  @override
  void initState() {
    super.initState();
    notifayHelper = NotifyHelper();
    notifayHelper.requestIOSPermissions();
    notifayHelper.initialzeNotification();
    taskController.getTasks();
  }

  TaskController taskController = Get.put(TaskController());
  DateTime selecteDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            ),
            onPressed: () {
              ThemeServices().changeTheme();
            },
          ),
          elevation: 0,
          backgroundColor: context.theme.appBarTheme.backgroundColor,
          // centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      if (taskController.taskList.isEmpty) {
                        return AlertDialog(
                          title: const Text('No Tasks'),
                          content:
                              const Text('You do not have any tasks to delete'),
                          actions: [
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      }
                      return AlertDialog(
                        title: const Text('Delete All Tasks'),
                        content: const Text(
                            'Are you sure you want to delete all tasks?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              notifayHelper.cancelAllNotification();
                              taskController.deleteAllTasks();
                              Get.back();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // notifayHelper.cancelAllNotification();
                  // taskController.deleteAllTasks();
                },
                icon: Icon(
                  Icons.cleaning_services_outlined,
                  size: 24,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                )),
            const CircleAvatar(
              backgroundImage: AssetImage('images/todolist.png'),
              radius: 20,
            ),
            const SizedBox(
              width: 18,
            )
          ],
        ),
        body: Column(
          children: [
            addTaskBar(),
            addDateBar(),
            const SizedBox(
              height: 6,
            ),
            showTask(),
            // showMessegeNoTask(),
          ],
        ));
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text('Today', style: headingStyle),
            ],
          ),
          MyButton(
            label: '+ AddTask',
            onPressed: () async {
              await Get.to(() => const AddTaskPage());
              taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 6),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          // New date selected

          selecteDate = date;
          taskController.getTasks();
        },
      ),
    );
  }

  showTask() {
    return Expanded(
      child: Obx(
        () {
          if (taskController.taskList.isEmpty) {
            return showMessegeNoTask();
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                taskController.getTasks();
              },
              child: ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
                itemBuilder: (context, index) {
                  var task = taskController.taskList[index];

                  debugPrint(task.repeat);
                  debugPrint(task.date);
                  debugPrint(DateFormat.yMd().format(selecteDate));

                  if (task.repeat == 'Daily' ||
                      task.date == DateFormat.yMd().format(selecteDate) ||
                      (task.repeat == 'Weekly' &&
                          selecteDate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == 'Monthly' &&
                          DateFormat.yMd().parse(task.date!).day ==
                              selecteDate.day)) {
                    // Check if task.startTime is not null before scheduling notification
                    if (task.startTime != null) {
                      // var hour = task.startTime!.split(':')[0];
                      // var minutes = task.startTime!.split(':')[1];

                      // Parse startTime into DateTime for notification scheduling
                      var date = DateFormat('hh:mm a').parse(task.startTime!);
                      var myTime = DateFormat('HH:mm').format(date);

                      // Schedule notification
                      notifayHelper.scheduledNotification(
                        int.parse(myTime.split(':')[0]),
                        int.parse(myTime.split(':')[1]),
                        task,
                      );
                    }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () => showBottomSheet(context, task),
                            child: TaskTile(
                              task: task,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: taskController.taskList.length,
              ),
            );
          }
        },
      ),
    );
  }

  showMessegeNoTask() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: () async {
              taskController.getTasks();
            },
            child: SingleChildScrollView(
              // wrap widget is used to wrap the children in a row or column and align them in a specific direction
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  SizeConfig.orientation == Orientation.portrait
                      ? const SizedBox(
                          height: 220,
                        )
                      : const SizedBox(
                          height: 6,
                        ),
                  SvgPicture.asset(
                    'images/task.svg',
                    height: 90,
                    color: primaryClr.withOpacity(0.5),
                    semanticsLabel: 'Task',
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      'You do not have any tasks yet!\nAdd a new tasks to make your days productive',
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 120)
                      : const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 4, left: 20, right: 20),
            width: SizeConfig.screenWidth,
            height: (SizeConfig.orientation == Orientation.landscape)
                ? (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.6
                    : SizeConfig.screenHeight * 0.8)
                : (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.30
                    : SizeConfig.screenHeight * 0.39),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? darkHeaderClr : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                task.isCompleted == 1
                    ? Container()
                    : buildBottomSheet(
                        label: 'Task Completed',
                        onTap: () {
                          notifayHelper.cancelNotification(task);
                          taskController.markTaskCompleted(task.id!);
                          Get.back();
                        },
                        clr: primaryClr,
                      ),
                // buildBottomSheet(
                //   label: 'Edit Task',
                //   onTap: () {
                //     Get.back();
                //     // Get.to(() => AddTaskPage(task: task));
                //   },
                //   clr: primaryClr,
                // ),

                // Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),

                buildBottomSheet(
                  label: 'Delete Task',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Task'),
                          content: const Text(
                              'Are you sure you want to delete this task?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                notifayHelper.cancelNotification(task);
                                taskController.deleteTasks(task);
                                Get.back();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  clr: Colors.red,
                ),
                Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
                buildBottomSheet(
                  label: 'Cancel',
                  onTap: () {
                    Get.back();
                  },
                  clr: primaryClr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(25),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
