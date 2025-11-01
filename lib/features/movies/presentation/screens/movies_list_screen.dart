import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/my_theme.dart';
import '../../../../core/theming/theme_cubit.dart';
import '../widgets/movie_list_item.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_outlined,
              color: theme.primary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Movies',
              style: theme.headlineStyle,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.wb_sunny_outlined,
              color: theme.primary,
            ),
            onPressed: () {
              print('toggleTheme');
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                MovieListItem(
                  title: 'The Matrix',
                  rating: 8.7,
                  genre: 'Sci-Fi',
                ),
                MovieListItem(
                  title: 'Fight Club',
                  rating: 8.8,
                  genre: 'Drama',
                ),
                MovieListItem(
                  title: 'Forrest Gump',
                  rating: 8.8,
                  genre: 'Drama',
                ),
                MovieListItem(
                  title: 'The Shawshank Redemption',
                  rating: 9.3,
                  genre: 'Drama',
                ),
                MovieListItem(
                  title: 'The Godfather',
                  rating: 9.2,
                  genre: 'Crime',
                ),
              ],
            ),
          ),
          Padding(
            padding: theme.containerPadding,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.secondary,
                  foregroundColor: theme.textSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: theme.cardBorderRadius,
                  ),
                ),
                child: Text(
                  'Load More Movies',
                  style: theme.buttonStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
