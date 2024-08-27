import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/models/book_model/book_model.dart';
import 'book_action.dart';
import 'book_rating.dart';
import 'custom_book_card.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .26,
            vertical: 10,
          ),
          child: CustomBookCard(
            imageUrl: book.volumeInfo.imageLinks?.thumbnail.isNotEmpty == true
                ? book.volumeInfo.imageLinks!.thumbnail
                : 'https://example.com/placeholder.jpg', // Use a valid placeholder image URL
          ),
        ),
        const SizedBox(height: 43),
        Text(
          book.volumeInfo.title ?? 'No Title Available',
          style: Styles.textStyle30.copyWith(
            fontFamily: GoogleFonts.libreBaskerville().fontFamily,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            book.volumeInfo.authors?[0] ?? '',
            style: Styles.textStyle18,
          ),
        ),
        const SizedBox(height: 18),
        BookRating(
          rating: book.volumeInfo.averageRating ?? 0,
          count: book.volumeInfo.ratingsCount ?? 0,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(height: 37),
        BookAction(
          bookModel: book,
        ),
      ],
    );
  }
}
