import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int starCount;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 20,
    this.starCount = 5,
    this.filledColor = Colors.amber,
    this.unfilledColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final starFill = (rating - index).clamp(0.0, 1.0);

        return Padding(
          padding: EdgeInsets.only(right: index != starCount - 1 ? 2 : 0),
          child: Stack(
            children: [
              Icon(Icons.star, size: size, color: unfilledColor),
              ClipRect(
                clipper: _StarClipper(starFill),
                child: Icon(Icons.star, size: size, color: filledColor),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillPercent;

  _StarClipper(this.fillPercent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fillPercent, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    return oldClipper.fillPercent != fillPercent;
  }
}
