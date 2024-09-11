import 'dart:developer';

import '../../tvs/domain/usecases/get_season_detail_usecase.dart';

class AppConstants {
  static const baseUrl = "https://api.themoviedb.org/3/";
  static const apiKey = '79be64051dee5258b7ce6688cbac5d97';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';

  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';

//   https://api.themoviedb.org/3/movie/550?api_key=79be64051dee5258b7ce6688cbac5d97&append_to_response=videos,credits,reviews,similar
  static String imageUrl(String path) => '$baseImageUrl$path';

  static String getMovieDetailsPath(int movieId) {
    return '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=videos,credits,reviews,similar';
  }

  static String getSearchPath(String title, String language) {
    log('language: $language');
    return 'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$title&language=$language';


    
  }


    static String getTvShowDetailsPath(int tvShowId) {
    return 'https://api.themoviedb.org/3/tv/$tvShowId?api_key=$apiKey&append_to_response=similar,videos';
  }

  // static String getSeasonDetailsPath(SeasonDetailsParams params) {
  //   return '$baseUrl/tv/${params.id}/season/${params.seasonNumber}?api_key=$apiKey';
  // }

  static String getAllPopularTvShowsPath(int page) {
    return 'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&page=$page&with_original_language=en';
  }

  static String getAllTopRatedTvShowsPath(int page) {
    return 'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&page=$page&with_original_language=en';
  }

  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';

  static const String castPlaceHolder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';

  static const String avatarPlaceHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049__480.png';

  static const String stillPlaceHolder =
      'https://popcornsg.s3.amazonaws.com/gallery/1577405144-six-year.png';


        // tv shows paths
  static const String onAirTvShowsPath =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey&with_original_language=en';

  static const String popularTvShowsPath =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&with_original_language=en';

  static const String topRatedTvShowsPath =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&with_original_language=en';


      
  static String getSeasonDetailsPath(SeasonDetailsParams params) {
    return 'https://api.themoviedb.org/3/tv/${params.id}/season/${params.seasonNumber}?api_key=$apiKey';
  }
}
