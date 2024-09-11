import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/core/resources/app_values.dart';

import '../../resources/app_routes.dart';

class SectionListViewCard extends StatelessWidget {
  final Media media;

  const SectionListViewCard({
    required this.media,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(right: 11),
      child: SizedBox(
        width: AppSize.s120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (media.isMovie) {
                  context.pushNamed(
                    AppRoutes.movieDetailsRoute,
                    extra: media.tmdbID,
                    // pathParameters: {'movieId': media.tmdbID.toString()},
                  );
                } else {
                  context.pushNamed(
                    AppRoutes.tvShowDetailsRoute,
                    extra: media.tmdbID,
                    // pathParameters: {'tvShowId': media.tmdbID.toString()},
                  );
                }

                // context.push(
                //   AppRoutes.movieDetailsRoute,
                //   extra: media.tmdbID,
                // );
              },

              // clipRRect is used to clip the image to a rounded rectangle shape with a radius of 8
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),

                // if the posterUrl is a network url, then use CachedNetworkImage to load the image
                // else use Image.asset to load the image from the assets folder
                child: media.posterUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: media.posterUrl,
                        width: double.infinity,
                        height: AppSize.s175,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          width: double.infinity,
                          height: AppSize.s175,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : Image.asset(
                        media.posterUrl,
                        width: double.infinity,
                        height: AppSize.s175,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: AppColors.ratingIconColor,
                      size: AppSize.s18,
                    ),
                    Text(
                      '${media.voteAverage}/10',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
