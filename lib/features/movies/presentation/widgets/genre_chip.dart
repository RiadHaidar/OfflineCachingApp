import 'package:flutter/material.dart';
import '../../../../core/theming/my_theme.dart';

class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing,
        vertical: theme.spacing / 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.textPrimary.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: theme.captionStyle,
      ),
    );
  }
}
