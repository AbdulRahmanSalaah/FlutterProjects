import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/domain/entities/media_details.dart';
// import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_cubit/watchlist_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/media.dart';
import 'slider_card_image.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.mediaDetails,
    required this.detailsWidget,
    super.key,
  });

  final MediaDetails mediaDetails;
  final Widget detailsWidget;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    // this will check if the item is added to the watchlist when the details card is built and set the isAdded property of the mediaDetails object
    context.read<WatchlistCubit>().checkIfItemAdded(mediaDetails.tmdbID);

    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: mediaDetails.backdropUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: SizedBox(
              height: size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mediaDetails.title,
                            maxLines: 2,
                            style: textTheme.titleMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p4,
                              bottom: AppPadding.p6,
                            ),
                            child: detailsWidget,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.ratingIconColor,
                                size: AppSize.s18,
                              ),
                              Text(
                                '${mediaDetails.voteAverage} ',
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                mediaDetails.voteCount,
                                style: textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(
                            'https://www.google.com/search?q=${mediaDetails.title} مشاهده مترجم');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      child: Container(
                        height: AppSize.s40,
                        width: AppSize.s40,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p12,
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconContainerColor,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondaryText,
                      size: AppSize.s20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    log('mediaDetails.id: ${mediaDetails.id}');
                    mediaDetails.isAdded
                        ? context
                            .read<WatchlistCubit>()
                            .removeWatchListItem(mediaDetails.id!)
                        : context.read<WatchlistCubit>().addWatchListItem(
                            Media.fromMediaDetails(mediaDetails));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconContainerColor,
                    ),
                    child: BlocConsumer<WatchlistCubit, WatchlistState>(
                      listener: (context, state) {
                        // if the item is added to the watchlist then set the id of the item to the id of the item in the watchlist and set isAdded to true
                        if (state is WatchlistItemAdded) {
                          log('WatchlistItemAdded id: ${state.item.tmdbID}');
                          log ('mediaDetails.id: ${mediaDetails.id}');
                          mediaDetails.id = state.item.tmdbID;
                          log ('mediaDetails.id after : ${mediaDetails.id}');
                          mediaDetails.isAdded = true;

                          // if the item is removed from the watchlist then set the id of the item to null and set isAdded to false
                        } else if (state is WatchlistItemRemoved) {
                          mediaDetails.id = null;

                          mediaDetails.isAdded = false;

                          // if the item is checked if it is added to the watchlist then set the id of the item to the id of the item in the watchlist and set isAdded to true
                        } else if (state is WatchlistItemCheck &&
                            state.tmdbId != -1) {
                              log ('WatchlistItemCheck id: ${state.tmdbId}');
                          mediaDetails.id = state.tmdbId;
                          mediaDetails.isAdded = true;
                        }
                      },
                      builder: (context, state) {
                        return Icon(
                          Icons.bookmark_rounded,
                          color: mediaDetails.isAdded
                              ? AppColors.primary
                              : AppColors.secondaryText,
                          size: AppSize.s20,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
