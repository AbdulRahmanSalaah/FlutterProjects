import 'package:doctors_app/features/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../doctors_list/doctors_shimmer_loading.dart';
import 'speciality_list_view.dart';
import 'speciality_shimmer_loading.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      //  buildWhen: (previous, current) => previous is SpecializationsLoading || previous is SpecializationsSuccess || previous is SpecializationsFailure,
      builder: (context, state) {
        if (state is HomeLoading) {
          return setupLoading(context);
        } else if (state is HomeSuccess) {
          return setupSuccess(state.specializationDataList);
        } else if (state is HomeFailure) {
          return setupError();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget setupLoading(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Column(
        children: [
          SpecialityShimmerLoading(),
          SizedBox(height: 8.0),
          DoctorsShimmerLoading(),
        ],
      ),
    );
  }

  Widget setupSuccess(specializationsList) {
    return SpecialityListView(
      specializationDataList: specializationsList ?? [],
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
