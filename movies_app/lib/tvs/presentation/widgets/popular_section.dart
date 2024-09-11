import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/presentation/controller/popular_cubit/popular_tv_cubit.dart';

import '../../../core/presentation/widgets/section_listview_card.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/loading_screens_with_skeletonizer/section_list_view_loading.dart';

class PopularTvSection extends StatelessWidget {
  const PopularTvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularTvCubit, PopularTvState>(
      builder: (context, state) {
        if (state is PopularTvLoading) {
          // Skeleton loading directly in the layout
          return const SectionListViewLoading();
        } else if (state is PopularTvSuccess) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: AppSize.s240,
              child: ListView.builder(
                // shrinkWrap: true, to make the ListView only occupy the space it needs to display its content and not occupy the entire screen
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.popularTvShows.length,
                itemBuilder: (context, index) {
                  final movie = state.popularTvShows[index];
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
