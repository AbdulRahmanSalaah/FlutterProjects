import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/resources/app_values.dart';

import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/movies/domain/entities/cast.dart';
import 'package:movies_app/movies/domain/entities/review.dart';

import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/movies/presentation/controller/movie_detail_cubit/movie_detail_cubit.dart';

import '../../../core/presentation/widgets/details_card.dart';
import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/loading_indicator.dart';
import '../../../core/presentation/widgets/section_listview.dart';
import '../../../core/presentation/widgets/section_title.dart';
import '../../../core/resources/app_strings.dart';
import '../widgets/cast_card.dart';
import '../widgets/movie_card_details.dart';
import '../widgets/review_card.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => MovieDetailCubit(getIt.get<GetMovieDetailsUsecase>())
        ..fetchMovieDetails(movieId),
      child: Scaffold(
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: LoadingIndicator(),
              );
            } else if (state is MovieDetailSuccess) {
              return MovieDetailsWidget(movieDetails: state.movieDetails);
            } else if (state is MovieDetailError) {
              return Center(
                child: ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<MovieDetailCubit>().fetchMovieDetails(movieId);
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

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    required this.movieDetails,
    super.key,
  });

  final MediaDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: movieDetails,
            detailsWidget: MovieCardDetails(movieDetails: movieDetails),
          ),
          getOverviewSection(movieDetails.overview),
          const SizedBox(
            height: AppSize.s8,
          ),
          _getCast(movieDetails.cast),
          _getReviews(movieDetails.reviews),
          getSimilarSection(movieDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}

Widget _getCast(List<Cast>? cast) {
  if (cast != null && cast.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.cast),
        SectionListView(
          height: AppSize.s190,
          itemCount: cast.length,
          itemBuilder: (context, index) => CastCard(
            cast: cast[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget _getReviews(List<Review>? reviews) {
  if (reviews != null && reviews.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.reviews),
        SectionListView(
          height: AppSize.s175,
          itemCount: reviews.length,
          itemBuilder: (context, index) => ReviewCard(
            review: reviews[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}
