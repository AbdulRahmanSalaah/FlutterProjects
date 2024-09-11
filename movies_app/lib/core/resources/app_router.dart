import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../movies/presentation/screens/movie_detail_screen.dart';
import '../../movies/presentation/screens/movies_screen.dart';
import '../../movies/presentation/screens/popular_movies_view.dart';
import '../../movies/presentation/screens/top_rated_movies_view.dart';
import '../../search/presentation/screens/search_view.dart';
import '../../tvs/presentation/screens/popular_tv_view.dart';
import '../../tvs/presentation/screens/top_rated_tv_view.dart';
import '../../tvs/presentation/screens/tv_details_view.dart';
import '../../tvs/presentation/screens/tv_screen.dart';
import '../../watchlist/presentation/screens/watchlist_view.dart';
import '../presentation/screens/main_page.dart';
import '../presentation/screens/splash_screen.dart';
import 'app_routes.dart';

const String splash = '/splash';
const String moviesPath = '/movies';
const String movieDetailsPath = '/movieDetails';
const String popularMoviesPath = '/popularMovies';
const String topRatedMoviesPath = '/topRatedMovies';
const String tvShowsPath = '/tvShows';
const String tvShowDetailsPath = '/tvShowDetails';
const String popularTVShowsPath = '/popularTVShows';
const String topRatedTVShowsPath = '/topRatedTVShows';
const String searchPath = '/search';
const String watchlistPath = '/watchlist';

class AppRouter {
  static final router = GoRouter(
    // initialLocation is the first page that will be displayed
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // shellRoute means  that the child will be displayed in the main page
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          // GoRoute(
          //   path: '/',
          //   builder: (context, state) => const MainMoviesScreen(),
          // ),
          GoRoute(
            name: AppRoutes.moviesRoute,
            path: moviesPath,
            builder: (context, state) {
              final key = state.extra as Key? ?? UniqueKey();

              return MainMoviesScreen(
                key: key,
              );
            },
          ),
          GoRoute(
            name: AppRoutes.movieDetailsRoute,
            path: movieDetailsPath,
            pageBuilder: (context, state) => CupertinoPage(
              child: MovieDetailsView(
                movieId: state.extra as int,
                // movieId: int.parse(state.pathParameters['movieId']!),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.popularMoviesRoute,
            path: popularMoviesPath,
            pageBuilder: (context, state) => const CupertinoPage(
              child: PopularMoviesView(),
            ),
          ),
          GoRoute(
            name: AppRoutes.topRatedMoviesRoute,
            path: topRatedMoviesPath,
            pageBuilder: (context, state) => const CupertinoPage(
              child: TopRatedMoviesView(),
            ),
          ),
          GoRoute(
            name: AppRoutes.searchRoute,
            path: searchPath,
            pageBuilder: (context, state) {
              final key = state.extra as Key? ?? UniqueKey();

              return NoTransitionPage(
                child: SearchView(key: key),
              );
            },
          ),

          GoRoute(
            name: AppRoutes.tvShowsRoute,
            path: tvShowsPath,
            pageBuilder: (context, state) {
              // key is used to rebuild the widget when the route changes
              final key = state.extra as Key? ?? UniqueKey();

              return NoTransitionPage(
                child: MainTvsScreen(key: key),
              );
            },
          ),

          GoRoute(
            name: AppRoutes.popularTvShowsRoute,
            path: popularTVShowsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PopularTvView(),
            ),
          ),

          GoRoute(
            name: AppRoutes.topRatedTvShowsRoute,
            path: topRatedTVShowsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TopRatedTvView(),
            ),
          ),

          GoRoute(
            name: AppRoutes.tvShowDetailsRoute,
            path: tvShowDetailsPath,
            pageBuilder: (context, state) => CupertinoPage(
              child: TVShowDetailsView(
                tvShowId: state.extra as int,
                // tvShowId: int.parse(state.pathParameters['tvShowId']!),
              ),
            ),
          ),

          GoRoute(
            name: AppRoutes.watchlistRoute,
            path: watchlistPath,
            pageBuilder: (context, state) {
              final key = state.extra as Key? ?? UniqueKey();
              return NoTransitionPage(
                child: WatchlistView(key: key),
              );
            },
          ),
        ],
      ),
    ],
  );
}
