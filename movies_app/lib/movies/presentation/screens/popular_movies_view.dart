import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/movies/presentation/controller/all_popular_cubit/all_popular_cubit.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/loading_indicator.dart';
import '../../../core/presentation/widgets/vertical_listview.dart';
import '../../../core/presentation/widgets/vertical_listview_card.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/services/service_locator.dart';
import '../../domain/usecases/get_all_popular_usecase.dart';

class PopularMoviesView extends StatelessWidget {
  const PopularMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllPopularCubit(getIt.get<GetAllPopularMoviesUseCase>())
            ..fetchAllPopularMovies(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: AppStrings.popularMovies,
          ),
        ),
        body: BlocBuilder<AllPopularCubit, AllPopularState>(
          builder: (context, state) {
            if (state is AllPopularLoading) {
              const Center(
                child: LoadingIndicator(),
              );
            } else if (state is AllPopularSuccess) {
              return PopularMoviesWidget(movies: state.movies);
            } else if (state is AllPopularError) {
              return Center(
                child: ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<AllPopularCubit>().fetchAllPopularMovies();
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

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPopularCubit, AllPopularState>(
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
