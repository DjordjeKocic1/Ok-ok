import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/review.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/star_rating.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final firstName = review.fromUser?.firstName ?? 'Nedostupan korisnik';
    final lastName = initial(review.fromUser?.firstName);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withValues(alpha: 0.5),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$firstName $lastName',
                  style: TextStyle(fontSize: context.sp(12)),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    StarRating(rating: review.rating, size: context.w(15)),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: TextStyle(fontSize: context.sp(12)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  review.comment,
                  style: TextStyle(fontSize: context.sp(12)),
                ),
              ],
            ),
          ),
          Text(
            formatDate(review.createdAt, format: 'dd.MM.yyyy. HH:mm'),
            style: TextStyle(
              fontSize: context.sp(10),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
