import 'package:flutter/material.dart';

import '../../../data/models/specializations_response_model.dart';
import 'doctors_list_view_item.dart';

class DoctorsListView extends StatelessWidget {
  final List<Doctors?>? doctorsList;
  const DoctorsListView({super.key, this.doctorsList});

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: doctorsList?.length,
    //     itemBuilder: (context, index) {
    //       return DoctorsListViewItem(
    //         doctorsModel: doctorsList?[index],
    //       );
    //     },
    //   ),
    // );

    return SliverList (
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return DoctorsListViewItem(
            doctorsModel: doctorsList?[index],
          );
        },
        childCount: doctorsList?.length,
      ),
    );
  }
}
