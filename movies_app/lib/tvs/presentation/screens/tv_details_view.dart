import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/presentation/widgets/loading_indicator.dart';

import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tvs/presentation/controller/tv_details_cubit/tv_details_cubit.dart';

import '../../../core/presentation/widgets/details_card.dart';
import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/section_title.dart';
import '../../domain/usecases/get_tv_show_details_usecase.dart';
import '../widgets/episode_card.dart';
import '../widgets/seasons_section.dart';
import '../widgets/tv_show_card_detail.dart';

class TVShowDetailsView extends StatelessWidget {
  const TVShowDetailsView({
    super.key,
    required this.tvShowId,
  });

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvDetailsCubit(getIt.get<GetTVShowDetailsUseCase>())
        ..fetchTVShowDetails(tvShowId),
      child: Scaffold(
        body: BlocBuilder<TvDetailsCubit, TvDetailsState>(
          builder: (context, state) {
            if (state is TvDetailsSuccess) {
              return TVShowDetailsWidget(tvShowDetails: state.tvShowDetails);
            } else if (state is TvDetailsError) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<TvDetailsCubit>().fetchTVShowDetails(tvShowId);
                },
              );
            } else if (state is TvDetailsLoading) {
              return const LoadingIndicator();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class TVShowDetailsWidget extends StatelessWidget {
  const TVShowDetailsWidget({
    super.key,
    required this.tvShowDetails,
  });

  final MediaDetails tvShowDetails;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: "Seasons" and "Similar"
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show main details (e.g. title, image, overview)
            DetailsCard(
              mediaDetails: tvShowDetails,
              detailsWidget: TVShowCardDetails(
                genres: tvShowDetails.genres,
                lastEpisode: tvShowDetails.lastEpisodeToAir!,
                seasons: tvShowDetails.seasons!,
              ),
            ),
            getOverviewSection(tvShowDetails.overview),
            const SectionTitle(title: AppStrings.lastEpisodeOnAir),
            EpisodeCard(episode: tvShowDetails.lastEpisodeToAir!),

            // Now placing TabBar and TabBarView after all the details
            const SizedBox(height: AppSize.s16), // Optional spacing

            const TabBar(
              indicatorColor: Color(0xffef233c),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: AppStrings.seasons,
                ),
                Tab(
                  text: 'MORE LIKE THIS',
                ),
              ],
            ),

            // Wrapping TabBarView inside a fixed-height container
            SizedBox(
              height: 350, // Adjust this height as necessary
              child: TabBarView(
                children: [
                  // Seasons Section
                  SeasonsSection(
                    tmdbID: tvShowDetails.tmdbID,
                    seasons: tvShowDetails.seasons!,
                  ),

                  // Similar Section
                  getSimilarSection(tvShowDetails.similar),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
