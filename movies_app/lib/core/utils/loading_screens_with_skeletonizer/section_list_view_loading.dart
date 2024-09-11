import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/entities/media.dart';
import '../../presentation/widgets/section_listview_card.dart';
import '../../resources/app_values.dart';

class SectionListViewLoading extends StatelessWidget {
  const SectionListViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
          height: AppSize.s240,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 10,
            itemBuilder: (context, index) {
              const dummyMovie = Media(
                tmdbID: 0,
                title: 'Title Title Title',
                posterUrl: 'assets/images/test.jpg',
                backdropUrl: '',
                overview: 'Overview',
                releaseDate: '2021-01-01',
                voteAverage: 7.5,
                isMovie: true,
              );

              return const SectionListViewCard(media: dummyMovie);
            },
          ),
        ),
      ),
    );
  }
}
