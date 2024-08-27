import 'package:bookly_app/Features/home/presentation/manger/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_error.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    // this is wrong way to use ListView.builder in CustomScrollView slivers list
    // return ListView.builder(
    //   // physics: const NeverScrollableScrollPhysics(),
    //   physics: const NeverScrollableScrollPhysics(),
    //   // shrinkWrap: true,

    //   padding: EdgeInsets.zero,
    //   itemCount: 10,
    //   itemBuilder: (context, index) {
    //     return const Padding(
    //       padding: EdgeInsets.symmetric(vertical: 10),
    //       child: BestSellerItems(),
    //     );
    //   },
    // );

// this is the correct way to use ListView.builder in CustomScrollView slivers lis
    return BlocBuilder<NewsetBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewsetBooksSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                  child: BestSellerItems(
                    bookModel: state.books[index],
                  ),
                );
              },
              childCount: state.books.length,
            ),
          );
        } else if (state is NewsetBooksLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is NewsetBooksFailure) {
           return SliverToBoxAdapter(
            child: CustomErrorWidget(errMessage: state.errMessage),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
