import 'package:flutter/material.dart';
import '../../../../core/theming/my_theme.dart';
import 'genre_chip.dart';
import 'movie_poster.dart';
import 'rating_widget.dart';

class MovieListItem extends StatelessWidget {
  final String title;
  final double rating;
  final String genre;
  final String? posterPath;
  final VoidCallback? onTap;

  const MovieListItem({
    super.key,
    required this.title,
    required this.rating,
    required this.genre,
    this.posterPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: theme.spacing,
          vertical: theme.spacing / 2,
        ),
        padding: EdgeInsets.all(theme.spacing * 0.75),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: theme.cardBorderRadius,
          boxShadow: [
            BoxShadow(
              color: theme.textSecondary.withOpacity(0.1),
              blurRadius: theme.cardElevation,
              offset: Offset(0, theme.cardElevation),
            ),
          ],
        ),
        child: Row(
          children: [
            MoviePoster(
              posterPath: posterPath,
              width: 100,
              height: 140,
            ),
            SizedBox(width: theme.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.bodyStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: theme.spacing / 2),
                  RatingWidget(rating: rating),
                  SizedBox(height: theme.spacing / 2),
                  GenreChip(genre: genre),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.textPrimary,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
