import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/presentation/controller/popular_cubit/popular_cubit.dart';
import 'package:movies_app/movies/presentation/controller/top_rated_cubit/top_rated_cubit.dart';

import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/section_header.dart';
import '../../../core/resources/app_routes.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/services/service_locator.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_top_rated_movies_usecase.dart';
import '../controller/now_playing_cubit/now_playing_cubit.dart';
import '../widgets/now_playing_section.dart';
import '../widgets/popular_section.dart';
import '../widgets/top_rated_section.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NowPlayingCubit(
            getIt.get<GetNowPlayingMoviesUsecase>(),
          )..fetchNowPlayingMovies(),
        ),
        BlocProvider(
          create: (context) =>
              PopularCubit(getIt.get<GetPopularMoviesUseCase>())
                ..fetchPopularMovies(),
        ),
        BlocProvider(
          create: (context) =>
              TopRatedCubit(getIt.get<GetTopRatedMoviesUsecase>())
                ..fetchTopRatedMovies(),
        )
      ],
      child: Scaffold(
        body: BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingFailure) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<NowPlayingCubit>().fetchNowPlayingMovies();
                  context.read<PopularCubit>().fetchPopularMovies();
                  context.read<TopRatedCubit>().fetchTopRatedMovies();
                },
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NowPlayingSection(),
                  SectionHeader(
                    title: AppStrings.popularMovies,
                    onSeeAllTap: () {
                      GoRouter.of(context).push(AppRoutes.popularMoviesRoute);
                    },
                  ),
                  const PopularSection(),
                  SectionHeader(
                    title: AppStrings.topRatedMovies,
                    onSeeAllTap: () {
                      GoRouter.of(context).push(AppRoutes.topRatedMoviesRoute);
                    },
                  ),
                  const TopRatedSection(),
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
