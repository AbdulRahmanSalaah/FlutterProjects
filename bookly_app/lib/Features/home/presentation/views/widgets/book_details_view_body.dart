import 'package:flutter/material.dart';

import 'package:bookly_app/Features/home/presentation/views/widgets/book_details_section.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/user_may_like_section.dart';

import '../../../../../core/models/book_model/book_model.dart';
import 'custom_book_details_app_bar.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.bookModel});
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            // hasScrollBody means that the CustomScrollView will not have a scrollable body and will take the full height of the screen.
            hasScrollBody: false,
            child: Column(
              children: [
                const CustomBookDetailsAppBar(),
                BookDetailsSection(
                  book: bookModel,
                ),
                const Expanded(
                  child: SizedBox(height: 50),
                ),
                const UserMayLikeSection(),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}
