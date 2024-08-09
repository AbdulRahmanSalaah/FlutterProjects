import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/history_hive_model.dart';
import '../storage/history_box.dart';
import '../theme/colors.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  HistoryListState createState() => HistoryListState();
}

class HistoryListState extends State<HistoryList> {
  List<HistoryModelHive> historyList = HistoryBox.getHistory();

  @override
  Widget build(BuildContext context) {
    // Sort the history list by date in descending order to show the latest game first
    historyList.sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      backgroundColor: GameColors.kLighterForeground,
      body: historyList.isEmpty
          ? Center(
              child: Text(
                'No game history!',
                style: TextStyle(
                  fontSize: 20,
                  color: GameColors.kWhitish,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.permanentMarker().fontFamily,
                ),
              ),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(historyList[index].toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            // Remove the dismissed item from the list
                            HistoryModelHive item = historyList[index];
                            historyList.removeAt(index);

                            HistoryBox.deleteHistory(item);

                            // Update the storage or database where history is stored
                            // Example: HistoryBox.saveHistory(historyList);
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Deleted"),
                              duration: Duration(milliseconds: 400),
                            ),
                          );
                        },
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.grey.withOpacity(0.35),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 12,
                                  decoration: BoxDecoration(
                                    color: historyList[index].winner == 'X'
                                        ? GameColors.kBlue
                                        : historyList[index].winner == 'draw'
                                            ? Colors.grey
                                            : GameColors.kPurple,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 30,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat('MMM d, y HH:mm').format(
                                              historyList[index]
                                                  .date
                                                  .toLocal()),
                                          style: GoogleFonts.chicle(
                                            fontSize: 17,
                                            fontWeight: GoogleFonts.novaCut()
                                                .fontWeight,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Wrap text inside a Flexible widget
                                            Flexible(
                                              child: Text(
                                                historyList[index].playerXName,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: GameColors.kBlue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GoogleFonts
                                                          .permanentMarker()
                                                      .fontFamily,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "VS",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts
                                                        .permanentMarker()
                                                    .fontFamily,
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            Flexible(
                                              child: Text(
                                                historyList[index].playerOName,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: GameColors.kPurple,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GoogleFonts
                                                          .permanentMarker()
                                                      .fontFamily,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: historyList.length,
                  ),
                ),
              ],
            ),
    );
  }
}
