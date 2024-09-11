import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';

import '../../../core/presentation/widgets/image_with_shimmer.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required this.item,
  });

  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // item.isMovie
            //     ? context.pushNamed(AppRoutes.movieDetailsRoute,
            //         pathParameters: {'movieId': item.tmdbID.toString()})
            //     : context.pushNamed(AppRoutes.tvShowDetailsRoute,
            //         pathParameters: {'tvShowId': item.tmdbID.toString()});
            // context.pushNamed(AppRoutes.movieDetailsRoute, extra: item.tmdbID);
            context.pushNamed(
              item.isMovie
                  ? AppRoutes.movieDetailsRoute
                  : AppRoutes.tvShowDetailsRoute,
              extra: item.tmdbID,
            );
          },
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: item.posterUrl,
                width: double.infinity,
                height: AppSize.s150,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
