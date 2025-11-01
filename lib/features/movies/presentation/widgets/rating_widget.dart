import 'package:flutter/material.dart';
import '../../../../core/theming/my_theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${rating.toStringAsFixed(1)}/10',
          style: theme.bodyStyle,
        ),
      ],
    );
  }
}
