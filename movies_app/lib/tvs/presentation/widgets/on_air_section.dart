import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/tvs/presentation/controller/on_air_cubit/on_air_tv_cubit.dart';

import '../../../core/resources/app_routes.dart';
import '../../../core/utils/app_constans.dart';
import '../../../core/utils/loading_screens_with_skeletonizer/now_playing_loading.dart';

class OnAirSection extends StatelessWidget {
  const OnAirSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnAirTvCubit, OnAirTvState>(
      builder: (context, state) {
        if (state is OnAirTvLoading) {
          // Skeleton loading closely resembling the actual layout
          return const NowPlayingSectionLoading();
        } else if (state is OnAirTvSuccess) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {},
              ),
              items: state.onAirTvShows.map(
                (item) {
                  return GestureDetector(
                    onTap: () {
                      // change it later to the tv details ...
                      // GoRouter.of(context).push(
                      //   AppRoutes.movieDetailsRoute,
                      //   extra: item.tmdbID,
                      // );.

                      context.push(
                        AppRoutes. tvShowDetailsRoute,
                        // pathParameters: {'tvShowId': item.tmdbID.toString()},
                        extra: item.tmdbID,
                      );
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0, 0.3, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: 560.0,
                            imageUrl: AppConstants.imageUrl(item.backdropUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'ON THE AIR '.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
