import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';
import 'package:ok_ok/widgets/star_rating.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    var ratingText = getAverageRating(
      userFakeData[0].ratingHistory.map((rt) => rt.rating).toList(),
    ).toStringAsFixed(1);

    return ScreenPadding(
      extra: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.star, size: 40, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ratings',
                      style: TextStyle(
                        fontSize: context.sp(15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View your ratings and comments.',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.outlined(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_outlined),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your ratings',
                  style: TextStyle(
                    fontSize: context.sp(15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Icon(Icons.star, color: AppColors.primary, size: context.w(20)),
              const SizedBox(width: 2),
              Text(ratingText, style: TextStyle(fontSize: context.sp(15))),
              const SizedBox(width: 2),
              Text(
                '(${userFakeData[0].ratingHistory.length.toString()})',
                style: TextStyle(fontSize: context.sp(15)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final rating in userFakeData[0].ratingHistory)
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          rating.firstName,
                          style: TextStyle(
                            fontSize: context.sp(14),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            StarRating(
                              rating: double.parse(rating.rating),
                              size: context.w(16),
                              filledColor: Colors.amber,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating.rating,
                              style: TextStyle(
                                fontSize: context.sp(14),
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          rating.comment,
                          style: TextStyle(
                            fontSize: context.sp(14),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
