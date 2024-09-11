import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/controller/popular_cubit/popular_cubit.dart';

import '../../../core/presentation/widgets/section_listview_card.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/loading_screens_with_skeletonizer/section_list_view_loading.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        if (state is PopularLoading) {
          // Skeleton loading directly in the layout
          return const SectionListViewLoading();
        } else if (state is PopularSuccess) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: AppSize.s240,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return SectionListViewCard(media: movie);
                },
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
