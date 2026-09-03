import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE9E5FA), Color(0xFFF7F6FC), Color(0xFFFFFFFF)],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 250,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login_background.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    Image.asset('assets/images/logo.png', width: 200),
                    const SizedBox(height: 12),
                    const Text(
                      'Ljudi pomažu ljudima.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      'Usluga na koju možeš da računaš.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabAlignment: TabAlignment.center,
                        labelColor: AppColors.primaryDark,
                        unselectedLabelColor: AppColors.textSecondary,
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorColor: AppColors.primary,
                        indicator: UnderlineTabIndicator(
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          insets: const EdgeInsets.symmetric(horizontal: -50),
                        ),
                        tabs: const [
                          Tab(text: 'Prijavi se'),
                          Tab(text: 'Napravi nalog'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      label: const Text('Adresa e-poste'),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      label: const Text('Sifra'),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: const Text(
                                      'Zaboravio si sifru?',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Prijavi se'),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          'ili',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.surface,
                                      overlayColor: AppColors.primaryDark,
                                      side: BorderSide(
                                        color: AppColors.border,
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          width: 30,
                                          'assets/images/google-icon.png',
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Nastavi sa google nalogom',
                                          style: TextStyle(
                                            color: AppColors.primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: AppColors.primaryDark,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'Nastavkom, prihvatate naše ',
                                          ),
                                          TextSpan(
                                            text: 'Uslove korišćenja',
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // navigate to Terms of Service screen, or open a URL
                                              },
                                          ),
                                          const TextSpan(text: ' i '),
                                          TextSpan(
                                            text: 'Politiku privatnosti',
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // navigate to Privacy Policy screen, or open a URL
                                              },
                                          ),
                                          const TextSpan(text: '.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text('Create Account'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
