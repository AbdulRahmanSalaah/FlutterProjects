import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_cubit/watchlist_cubit.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/presentation/widgets/loading_indicator.dart';
import '../../../core/presentation/widgets/vertical_listview_card.dart';
import '../../../core/resources/app_colors.dart';
import '../../domain/usecases/add_watchlist_item_usecase.dart';
import '../../domain/usecases/check_if_item_added_usecase.dart';
import '../../domain/usecases/get_watchlist_items_usecase.dart';
import '../../domain/usecases/remove_watchlist_item_usecase.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

  Future<void> _refreshWatchlist(BuildContext context) async {
    // Trigger the refresh action
    context.read<WatchlistCubit>().getWatchListItems();
  }

  @override
  Widget build(BuildContext context) {
    log('Building WatchlistView');
    return BlocProvider(
      create: (context) => WatchlistCubit(
        getIt.get<AddWatchlistItemUseCase>(),
        getIt.get<RemoveWatchlistItemUseCase>(),
        getIt.get<CheckIfItemAddedUseCase>(),
        getIt.get<GetWatchlistItemsUseCase>(),
      )..getWatchListItems(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: AppStrings.watchlist,
          ),
        ),
        body: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            log('WatchlistView state: $state');
            if (state is WatchlistLoading) {
              return const LoadingIndicator();
            } else if (state is WatchlistSuccess) {
              return RefreshIndicator(
                color: AppColors.secondary,
                onRefresh: () => _refreshWatchlist(context),
                child: WatchlistWidget(items: state.items),
              );
            } else if (state is WatchlistEmpty) {
              return const Center(
                child: Text('Empty Watchlist', style: TextStyle(fontSize: 24)),
              );
            } else if (state is WatchlistError) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<WatchlistCubit>().getWatchListItems();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({
    super.key,
    required this.items,
  });

  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      itemBuilder: (context, index) {
        return VerticalListViewCard(media: items[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
    );
  }
}
