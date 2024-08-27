import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_error.dart';
import '../../../../home/presentation/views/widgets/best_seller_item.dart';
import '../manger/search_cubit/search_books_cubit.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 29,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(child: CustomSearchTextField()),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<SearchBooksCubit, SearchBooksState>(
                  builder: (context, state) {
                    if (state is SearchBooksSuccess && state.books.isNotEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          'Search Result',
                          style: Styles.textStyle18,
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Hide the "Search Result" text
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        const SearchResultListView(),
      ],
    );
  }
}

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBooksCubit, SearchBooksState>(
      builder: (context, state) {
        if (state is SearchBooksInitial) {
          // Show initial message before search
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Please enter a book title to start searching.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          );
        } else if (state is SearchBooksLoading) {
          // Show loading indicator during search
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SearchBooksSuccess) {
          // Check if the search returned any results
          if (state.books.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'No results found. Please try another search.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
            );
          } else {
            // Show search results
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 27),
                    child: BestSellerItems(
                      bookModel: state.books[index],
                    ),
                  );
                },
                childCount: state.books.length,
              ),
            );
          }
        } else if (state is SearchBooksError) {
          // Show error message if search fails
          return SliverToBoxAdapter(
            child: CustomErrorWidget(errMessage: state.message),
          );
        } else {
          // This block should be unreachable, but is included for safety.
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Unexpected error occurred.'),
            ),
          );
        }
      },
    );
  }
}
