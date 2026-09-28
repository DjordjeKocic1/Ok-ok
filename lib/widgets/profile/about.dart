import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScreenPadding(
        extra: EdgeInsets.only(top: 30),
        child: Column(
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
                  child: Icon(
                    Icons.info_outlined,
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
                        'O OKOK-u',
                        style: TextStyle(
                          fontSize: context.sp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'O OKOK-u',
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
            Text(
              'OKOK povezuje ljude koji treba da pošalju paket sa putnicima koji već idu u istom pravcu. Umesto plaćanja kurira, pošiljaoci pronalaze nekoga na svojoj ruti, a putnici svoje putovanje mogu da učine korisnijim.',
              style: TextStyle(fontSize: context.sp(14)),
            ),
            const SizedBox(height: 10),
            Text(
              'Kako funkcioniše',
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Unesi odakle i dokle ide paket, pregledaj putnike na toj ruti i pošalji zahtev onome koga izabereš. Putnik pregleda podatke o paketu i prihvata ili odbija zahtev. Kad ga prihvati, dogovarate predaju, a paket putuje sa njim do odredišta.',
              style: TextStyle(fontSize: context.sp(12)),
            ),
            const SizedBox(height: 10),
            Text(
              'Zasnovano na poverenju',
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Poverenje je važno kad stranci pomažu jedni drugima, zato OKOK nudi alate za dobre odluke: verifikaciju profila, ocene i recenzije i jasna pravila o tome šta se može slati. Preporučujemo da pre slanja zahteva pogledaš profil putnika i da razgovore vodiš unutar aplikacije.',
              style: TextStyle(fontSize: context.sp(14)),
            ),
            const SizedBox(height: 10),
            Text(
              'Šta OKOK jeste, a šta nije',
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'OKOK je platforma koja povezuje pošiljaoce i putnike. Dogovor oko paketa se sklapa direktno između dvoje korisnika. OKOK ne prevozi pakete i ne osigurava ih, zato pročitaj Uslove korišćenja pre nego što nešto pošalješ ili poneseš.',
              style: TextStyle(fontSize: context.sp(14)),
            ),
            const SizedBox(height: 10),
            Text(
              'Treba ti pomoć?',
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: context.sp(14),
                ),
                children: [
                  TextSpan(text: 'Pitanja ili problemi? Piši nam na'),
                  TextSpan(
                    text: ' okok_support@gmail.com.',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Verzija 1.0.0',
              style: TextStyle(
                fontSize: context.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
