import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/presentation/widgets/loading_indicator.dart';
import 'package:movies_app/search/presentation/controller/search_cubit/search_cubit.dart';

import '../../../core/presentation/widgets/error_screen.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/services/service_locator.dart';
import '../../domain/usecases/search_usecase.dart';
import '../widgets/search_field.dart';
import '../widgets/search_grid_view.dart';
import '../widgets/search_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt.get<SearchUseCase>()),
      child: const SearchWidget(),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p16,
            right: AppPadding.p16,
          ),
          child: Column(
            children: [
              const SearchField(),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SearchText();
                  }
                  if (state is SearchLoading) {
                    return const LoadingIndicator();
                  } else if (state is SearchSuccess) {
                    return SearchGridView(
                      results: state.searchResults,
                    );
                  } else if (state is SearchFailure) {
                    return Center(
                      child: ErrorScreen(
                        onTryAgainPressed: () {
                          context.read<SearchCubit>().fetchSearchResults('');
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.noResults,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
