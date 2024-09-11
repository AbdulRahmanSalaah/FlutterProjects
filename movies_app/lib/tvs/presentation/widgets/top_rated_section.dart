import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/presentation/controller/top_rated_tv_cubit/top_rated_tv_cubit.dart';

import '../../../core/presentation/widgets/section_listview_card.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/loading_screens_with_skeletonizer/section_list_view_loading.dart';

class TopRatedTvSection extends StatelessWidget {
  const TopRatedTvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
      builder: (context, state) {
        if (state is TopRatedTvLoading) {
          return const SectionListViewLoading();
        } else if (state is TopRatedTvSuccess) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: AppSize.s240,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.topRatedTvShows.length,
                itemBuilder: (context, index) {
                  final movie = state.topRatedTvShows[index];
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
