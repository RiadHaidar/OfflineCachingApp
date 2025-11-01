import 'package:flutter/material.dart';
import '../../../../core/theming/my_theme.dart';

class MoviePoster extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;
  final double borderRadius;

  const MoviePoster({
    super.key,
    this.posterPath,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: posterPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$posterPath',
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder(theme);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildPlaceholder(theme);
                },
              ),
            )
          : _buildPlaceholder(theme),
    );
  }

  Widget _buildPlaceholder(MyTheme theme) {
    return Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        color: theme.textSecondary,
        size: width * 0.3,
      ),
    );
  }
}
