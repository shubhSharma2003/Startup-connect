import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final void Function(double)? onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 24.0,
    this.color = Colors.amber,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: onRatingChanged != null ? () => onRatingChanged!(index + 1.0) : null,
          child: Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                    ? Icons.star_half
                    : Icons.star_border,
            color: color,
            size: size,
          ),
        );
      }),
    );
  }
}
