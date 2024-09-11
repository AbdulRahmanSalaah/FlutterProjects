import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/widgets/loading_indicator.dart';

import 'package:movies_app/core/resources/app_strings.dart';

import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/movies/presentation/controller/all_top_rated_cubit/all_top_rated_cubit.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/vertical_listview.dart';
import '../../../core/presentation/widgets/vertical_listview_card.dart';
import '../../domain/usecases/get_all_top_rated_usecase.dart';

class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllTopRatedCubit(getIt.get<GetAllTopRatedMoviesUseCase>())
            ..fetchAllTopRatedMovies(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: AppStrings.topRatedMovies,
          ),
        ),
        body: BlocBuilder<AllTopRatedCubit, AllTopRatedState>(
          builder: (context, state) {
            if (state is AllTopRatedLoading) {
              const LoadingIndicator();
            } else if (state is AllTopRatedSuccess) {
              return TopRatedMoviesWidget(movies: state.movies);
            } else if (state is AllTopRatedError) {
              return Center(
                child: ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<AllTopRatedCubit>().fetchAllTopRatedMovies();
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTopRatedCubit, AllTopRatedState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return VerticalListViewCard(media: movies[index]);
          },
        );
      },
    );
  }
}
