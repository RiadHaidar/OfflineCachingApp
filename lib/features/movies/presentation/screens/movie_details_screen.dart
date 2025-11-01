import 'package:flutter/material.dart';
import '../../../../core/theming/my_theme.dart';
import '../widgets/genre_chip.dart';
import '../widgets/movie_poster.dart';
import '../widgets/rating_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primary,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Movie Details',
          style: theme.headlineStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: theme.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MoviePoster(
                  posterPath: null,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.9,
                  borderRadius: 16,
                ),
              ),
              SizedBox(height: theme.spacing * 1.5),
              Text(
                'The Matrix',
                style: theme.headlineStyle.copyWith(fontSize: 28),
              ),
              SizedBox(height: theme.spacing),
              Row(
                children: [
                  const RatingWidget(rating: 8.7),
                  SizedBox(width: theme.spacing),
                  const GenreChip(genre: 'Sci-Fi'),
                ],
              ),
              SizedBox(height: theme.spacing * 2),
              Text(
                'Description',
                style: theme.headlineStyle.copyWith(fontSize: 20),
              ),
              SizedBox(height: theme.spacing * 0.75),
              Text(
                'A computer programmer discovers that reality as he knows it is a simulation created by machines.',
                style: theme.bodyStyle.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
