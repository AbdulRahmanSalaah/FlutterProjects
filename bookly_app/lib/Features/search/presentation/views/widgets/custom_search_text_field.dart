import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../manger/search_cubit/search_books_cubit.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        hintText: 'Search for books',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        suffixIcon: IconButton(
          onPressed: () {
            final searchQuery = searchController.text;
            debugPrint(searchQuery);
            BlocProvider.of<SearchBooksCubit>(context)
                .fetchSearchBooks(query: searchQuery);
          },
          icon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 20,
            color: Colors.white70,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white70, // Border color
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(30.0), // Rounded corners
    );
  }
}
