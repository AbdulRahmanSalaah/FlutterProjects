import 'package:bookly_app/Features/home/presentation/manger/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import 'best_seller_list_view.dart';
import 'custom_app_bar.dart';
import 'list_view_items.dart';
import '../../manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeaturedBooksCubit>().fetchFeaturedBooks();
        context.read<NewsetBooksCubit>().fetchNewestBooks();
      },
      child: BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
        builder: (context, featuredBooksState) {
          return BlocBuilder<NewsetBooksCubit, NewestBooksState>(
            builder: (context, newestBooksState) {
              if (featuredBooksState is FeaturedBooksFailure ||
                  newestBooksState is NewsetBooksFailure) {
                return _buildErrorState(context);
              } else {
                return const CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 20),
                            child: ListViewItems(),
                          ),
                          SizedBox(height: 50),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(' Newest Books  ',
                                style: Styles.textStyle18),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    BestSellerListView(),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No Internet Connection', style: Styles.textStyle18),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Use BuildContext to trigger cubit actions
              context.read<FeaturedBooksCubit>().fetchFeaturedBooks();
              context.read<NewsetBooksCubit>().fetchNewestBooks();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
