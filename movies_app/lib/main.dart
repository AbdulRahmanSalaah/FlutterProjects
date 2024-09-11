import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_cubit/watchlist_cubit.dart';

import 'core/domain/entities/media.dart';
import 'core/resources/app_router.dart';
import 'core/resources/app_strings.dart';
import 'core/resources/app_theme.dart';
import 'core/services/service_locator.dart';
import 'watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'watchlist/domain/usecases/check_if_item_added_usecase.dart';
import 'watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MediaAdapter());
  await Hive.openBox('items');
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => WatchlistCubit(
        getIt.get<AddWatchlistItemUseCase>(),
        getIt.get<RemoveWatchlistItemUseCase>(),
        getIt.get<CheckIfItemAddedUseCase>(),
        getIt.get<GetWatchlistItemsUseCase>(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
