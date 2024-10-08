import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tvs/presentation/controller/tv_season_details_cubit/tv_season_details_cubit.dart';

import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/image_with_shimmer.dart';
import '../../../core/presentation/widgets/loading_indicator.dart';
import '../../domain/entities/season.dart';
import '../../domain/usecases/get_season_detail_usecase.dart';
import 'episode_widget.dart';

class SeasonCard extends StatelessWidget {
  const SeasonCard({
    super.key,
    required this.season,
    required this.tvShowId,
  });

  final Season season;
  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        _showBottomSheet(context, tvShowId, season.seasonNumber);
      },
      child: SizedBox(
        width: double.infinity,
        height: AppSize.s160,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: AppPadding.p16, top: AppPadding.p10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: ImageWithShimmer(
                  imageUrl: season.posterUrl,
                  width: AppSize.s110,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    season.name,
                    style: textTheme.bodyMedium,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p6),
                    child: Text(
                      '${season.episodeCount} ${AppStrings.episodes.toLowerCase()}',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  if (season.airDate.isNotEmpty) ...[
                    Text(
                      '${AppStrings.airDate} ${season.airDate}',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                  if (season.overview.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p4),
                      child: Text(
                        season.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryText,
              size: AppSize.s18,
            )
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, int id, int seasonNumber) {
  showCustomBottomSheet(
    context,
    BlocProvider(
      create: (_) => TvSeasonDetailsCubit(
        getIt.get<GetSeasonDetailsUseCase>(),
      )..fetchSeasonDetails(
          id, seasonNumber), // Fetch details when bottom sheet is shown
      child: BlocBuilder<TvSeasonDetailsCubit, TvSeasonDetailsState>(
        builder: (context, state) {
          if (state is TvSeasonDetailsLoading) {
            return const LoadingIndicator();
          }
          if (state is TvSeasonDetailsSuccess) {
            return EpisodesWidget(episodes: state.seasonDetails.episodes);
          }
          if (state is TvSeasonDetailsError) {
            return ErrorScreen(
              onTryAgainPressed: () {
                context
                    .read<TvSeasonDetailsCubit>()
                    .fetchSeasonDetails(id, seasonNumber);
              },
            );
          }
          return Container(); // Handle default case
        },
      ),
    ),
  );
}
