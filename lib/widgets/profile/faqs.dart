import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class FaqItem {
  final String question;
  final String answer;
  const FaqItem(this.question, this.answer);
}

const faqs = [
  FaqItem(
    'How does the app work?',
    'Enter your starting location and destination. You will see users who are traveling in that direction. Choose a suitable traveler and send them a request to transport your package.',
  ),
  FaqItem(
    'How can I send a package?',
    'Enter where the package is going from and where it is going to. Browse the available travelers and select the person whose route and travel details work best for you.',
  ),
  FaqItem(
    'What information do I need to provide about my package?',
    'When sending a request, you need to provide the package weight and a description of what you are sending.',
  ),
  FaqItem(
    'What items can I send?',
    'Only legal and permitted items can be transported through the app. It is forbidden to send illegal or dangerous items, including drugs, weapons, explosives, flammable or hazardous materials, cash, and any items restricted by law. Sending prohibited items may result in your account being suspended.',
  ),
  FaqItem(
    'How should I prepare my package?',
    'Make sure your package is securely packed and suitable for transportation. The contents should be protected from damage during the journey.',
  ),
  FaqItem(
    'What information should I include in the package description?',
    'Clearly describe what you are sending. For example, mention the type of item and any important information the traveler should know.',
  ),
  FaqItem(
    'What happens after I send a request?',
    'The traveler receives your request and can review the package details. You will be notified when the request is accepted or declined.',
  ),
  FaqItem(
    'What happens if my request is declined?',
    'You can choose another traveler from the available list and send them a new request.',
  ),
  FaqItem(
    'What happens when the package reaches its destination?',
    'The package is handed over to the recipient according to the details agreed with the traveler.',
  ),
  FaqItem(
    'How do I know if a traveler is trustworthy?',
    'Check the traveler\'s profile before sending a request. Look at their ratings, reviews, number of completed deliveries and whether they have the Verified badge. We recommend choosing travelers with a verified profile and positive reviews.',
  ),
  FaqItem(
    'What does the Verified badge mean?',
    'It means the user has confirmed their identity details, such as email and phone number. It helps build trust, but it is not a guarantee of someone\'s behavior, so always check ratings and reviews too.',
  ),
  FaqItem(
    'Can the traveler check what is inside my package?',
    'Yes. Travelers have the right to ask to see the contents before accepting the package, because they are responsible for what they carry. If a sender refuses, the traveler can decline the request.',
  ),
  FaqItem(
    'Is it safe to send valuable items?',
    'We recommend not sending items of high value, cash, or irreplaceable belongings. OKOK connects senders and travelers but does not insure packages, so send only what you are comfortable with.',
  ),
  FaqItem(
    'What should I do if I suspect a user is dishonest?',
    'Do not send or accept the package. Stop communicating with the user and report the problem to okok_support@gmail.com with as many details as possible, such as the user\'s name, route and screenshots of the conversation.',
  ),
  FaqItem(
    'What if there is a problem with my package?',
    'If your package is lost, damaged, or there is another problem with the delivery, contact the other user and report the issue through email okok_support@gmail.com.',
  ),
  FaqItem(
    'Who is responsible for the package?',
    'OKOK is a platform that connects senders and travelers. The agreement about the package is made directly between the two users, so please read the Terms of Use before sending or carrying a package.',
  ),
];

class Faqs extends StatelessWidget {
  const Faqs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScreenPadding(
        extra: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.quiz_outlined,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cesto postavljena pitanja',
                        style: TextStyle(
                          fontSize: context.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cesto postavljena pitanja',
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
            for (final faq in faqs)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  title: Text(
                    faq.question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  shape: const Border(),
                  collapsedShape: const Border(),
                  children: [
                    Text(
                      faq.answer,
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
