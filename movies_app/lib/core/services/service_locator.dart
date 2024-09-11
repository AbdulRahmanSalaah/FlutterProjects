import 'package:get_it/get_it.dart';
import 'package:movies_app/movies/domain/repository/base_movie_repo.dart';
import 'package:movies_app/search/domain/usecases/search_usecase.dart';
import 'package:movies_app/tvs/data/datasource/tv_remote_data_source.dart';
import 'package:movies_app/tvs/domain/repository/base_tv_repo.dart';
import 'package:movies_app/tvs/domain/usecases/get_all_top_rated_tv_usecase.dart';
import 'package:movies_app/tvs/domain/usecases/get_season_detail_usecase.dart';
import 'package:movies_app/tvs/domain/usecases/get_tv_show_details_usecase.dart';
import 'package:movies_app/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:movies_app/watchlist/domain/usecases/add_watchlist_item_usecase.dart';

import '../../movies/data/datasource/movie_remote_data_source.dart';
import '../../movies/data/repository/movies_repo_impl.dart';
import '../../movies/domain/usecases/get_all_popular_usecase.dart';
import '../../movies/domain/usecases/get_all_top_rated_usecase.dart';
import '../../movies/domain/usecases/get_movie_details_usecase.dart';
import '../../movies/domain/usecases/get_now_playing_movies_usecase.dart';
import '../../movies/domain/usecases/get_popular_movies_usecase.dart';
import '../../movies/domain/usecases/get_top_rated_movies_usecase.dart';
import '../../search/data/datasource/search_remote_data_source.dart';
import '../../search/data/repository/search_repo_impl.dart';
import '../../search/domain/repository/base_search_repo.dart';
import '../../tvs/data/repository/tv_repo_impl.dart';
import '../../tvs/domain/usecases/get_all_popular_tv_usecase.dart';
import '../../tvs/domain/usecases/get_now_playing_tv_usecase.dart';
import '../../tvs/domain/usecases/get_popular_tv_usecase.dart';
import '../../tvs/domain/usecases/get_top_rated_tv_usecase.dart';
import '../../watchlist/data/repository/watchlist_repo_impl.dart';
import '../../watchlist/domain/repository/watchlist_repo.dart';
import '../../watchlist/domain/usecases/check_if_item_added_usecase.dart';
import '../../watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import '../../watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Data source for movies module
  getIt.registerSingleton<BaseMovieRemoteDataSource>(
    MovieRemoteDataSource(),
  );

  // Repository
  getIt.registerSingleton<BaseMovieRepo>(
    MoviesRepoImpl(
      getIt.get<BaseMovieRemoteDataSource>(),
    ),
  );

  // Use case
  getIt.registerSingleton<GetNowPlayingMoviesUsecase>(
    GetNowPlayingMoviesUsecase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  getIt.registerSingleton<GetPopularMoviesUseCase>(
    GetPopularMoviesUseCase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  getIt.registerSingleton<GetTopRatedMoviesUsecase>(
    GetTopRatedMoviesUsecase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  getIt.registerSingleton<GetMovieDetailsUsecase>(
    GetMovieDetailsUsecase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  getIt.registerSingleton<GetAllPopularMoviesUseCase>(
    GetAllPopularMoviesUseCase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  getIt.registerSingleton<GetAllTopRatedMoviesUseCase>(
    GetAllTopRatedMoviesUseCase(
      getIt.get<BaseMovieRepo>(),
    ),
  );

  // Data source for search module

  getIt.registerSingleton<BaseSearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(),
  );

  // Repository for search module

  getIt.registerSingleton<BaseSearchRepository>(
    SearchRepositoryImpl(
      getIt.get<BaseSearchRemoteDataSource>(),
    ),
  );

  // Use case for search module

  getIt.registerSingleton<SearchUseCase>(
    SearchUseCase(
      getIt.get<BaseSearchRepository>(),
    ),
  );

// Data Source for Tvs module

  getIt.registerSingleton<BaseTVShowsRemoteDataSource>(
    TVShowsRemoteDataSourceImpl(),
  );

  // Repository for Tvs module

  getIt.registerSingleton<BaseTvRepo>(
    TVShowsRepositoryImpl(
      getIt.get<BaseTVShowsRemoteDataSource>(),
    ),
  );

  // use case for Tvs module

  getIt.registerSingleton<GetPopularTvUsecase>(
    GetPopularTvUsecase(
      getIt.get<BaseTvRepo>(),
    ),
  );

  getIt.registerSingleton<GetOnAirTvUsecase>(
    GetOnAirTvUsecase(
      getIt.get<BaseTvRepo>(),
    ),
  );

  getIt.registerSingleton<GetTopRatedTvUsecase>(
    GetTopRatedTvUsecase(
      getIt.get<BaseTvRepo>(),
    ),
  );

  getIt.registerSingleton<GetAllPopularTvUsecase>(
    GetAllPopularTvUsecase(
      getIt.get<BaseTvRepo>(),
    ),
  );
  getIt.registerSingleton<GetAllTopRatedTvUsecase>(
    GetAllTopRatedTvUsecase(
      getIt.get<BaseTvRepo>(),
    ),
  );

  getIt.registerSingleton<GetTVShowDetailsUseCase>(
    GetTVShowDetailsUseCase(
      getIt.get<BaseTvRepo>(),
    ),
  );
  getIt.registerSingleton<GetSeasonDetailsUseCase>(
    GetSeasonDetailsUseCase(
      getIt.get<BaseTvRepo>(),
    ),
  );

  // Data Source for Watchlist module

  getIt.registerSingleton<BaseWatchlistLocalDataSource>(
    WatchlistLocalDataSourceImpl(),
  );

  // Repository for Watchlist module

  getIt.registerSingleton<WatchlistRepository>(
    WatchListRepositoryImpl(
      getIt.get<BaseWatchlistLocalDataSource>(),
    ),
  );

  // Use case for Watchlist module

  getIt.registerSingleton<RemoveWatchlistItemUseCase>(
    RemoveWatchlistItemUseCase(
      getIt.get<WatchlistRepository>(),
    ),
  );

  getIt.registerSingleton<AddWatchlistItemUseCase>(
    AddWatchlistItemUseCase(
      getIt.get<WatchlistRepository>(),
    ),
  );

  getIt.registerSingleton<CheckIfItemAddedUseCase>(
    CheckIfItemAddedUseCase(
      getIt.get<WatchlistRepository>(),
    ),
  );

  getIt.registerSingleton<GetWatchlistItemsUseCase>(
    GetWatchlistItemsUseCase(
      getIt.get<WatchlistRepository>(),
    ),
  );
}
