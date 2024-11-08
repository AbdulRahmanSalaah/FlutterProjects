import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/home_cubit/home_cubit.dart';
import 'doctors_list_view.dart';

class DoctorsBlocBuilder extends StatelessWidget {
  const DoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      
      builder: (context, state) {
        if (state is HomeSuccess) {
          return setupSuccess(state.doctorsList);
        } else if (state is HomeFailure) {
          return SliverToBoxAdapter(child: setupError());
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }

  Widget setupSuccess(doctorsList) {
    return DoctorsListView(
      doctorsList: doctorsList,
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
