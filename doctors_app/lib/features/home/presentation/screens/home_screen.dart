import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/doctor_blue_container.dart';
import '../widgets/doctors_list/doctros_bloc_builder.dart';
import '../widgets/doctors_speciality_see_all.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/specializations_list/specializations_bloc_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                // color: Colors.amber,
                width: double.infinity,

                margin: const EdgeInsets.fromLTRB(
                  20.0,
                  16.0,
                  20.0,
                  28.0,
                ),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeTopBar(),
                    const DoctorsBlueContainer(),
                    SizedBox(height: 24.h),
                    const DoctorsSpecialitySeeAll(
                      name: 'Doctor Speciality',
                    ),
                    SizedBox(height: 18.h),
                    const SpecializationsBlocBuilder(),
                    SizedBox(height: 12.h),
                    const DoctorsSpecialitySeeAll(
                      name: 'Recommendation Doctor',
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
            const DoctorsBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
