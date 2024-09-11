import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/tvs/domain/usecases/get_now_playing_tv_usecase.dart';
import 'package:movies_app/tvs/presentation/controller/on_air_cubit/on_air_tv_cubit.dart';
import 'package:movies_app/tvs/presentation/controller/popular_cubit/popular_tv_cubit.dart';
import 'package:movies_app/tvs/presentation/widgets/on_air_section.dart';

import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/section_header.dart';
import '../../../core/resources/app_routes.dart';
import '../../../core/resources/app_strings.dart';
import '../../domain/usecases/get_popular_tv_usecase.dart';
import '../../domain/usecases/get_top_rated_tv_usecase.dart';
import '../controller/top_rated_tv_cubit/top_rated_tv_cubit.dart';
import '../widgets/popular_section.dart';
import '../widgets/top_rated_section.dart';

class MainTvsScreen extends StatelessWidget {
  const MainTvsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => OnAirTvCubit(getIt.get<GetOnAirTvUsecase>())
              ..fetchOnAirTvShows()),
        BlocProvider(
          create: (context) => TopRatedTvCubit(
            getIt.get<GetTopRatedTvUsecase>(),
          )..fetchTopRatedTvShows(),
        ),
        BlocProvider(
          create: (context) => PopularTvCubit(getIt.get<GetPopularTvUsecase>())
            ..fetchPopularTvShows(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<OnAirTvCubit, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvError) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<OnAirTvCubit>().fetchOnAirTvShows();
                  context.read<TopRatedTvCubit>().fetchTopRatedTvShows();
                  context.read<PopularTvCubit>().fetchPopularTvShows();
                },
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnAirSection(),
                  SectionHeader(
                    title: AppStrings.popularShows,
                    onSeeAllTap: () {
                      // change it later to all popular tvs...
                      GoRouter.of(context).push( AppRoutes.popularTvShowsRoute);
                    },
                  ),
                  const PopularTvSection(),
                  SectionHeader(
                    title: AppStrings.topRatedShows,
                    onSeeAllTap: () {
                      // change it later to all top rated tvs...
                      GoRouter.of(context).push(AppRoutes.topRatedTvShowsRoute);
                    },
                  ),
                  const TopRatedTvSection(),
                  const SizedBox(height: 50.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
