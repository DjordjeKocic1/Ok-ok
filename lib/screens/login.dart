import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/widgets/auth/create_account_tab.dart';
import 'package:ok_ok/widgets/auth/login_tab.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    Image.asset('assets/images/logo.png', width: 250),
                    const Text(
                      'Ljudi pomažu ljudima.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      'Usluga na koju možeš da računaš.',
                      style: TextStyle(fontSize: 13),
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: TabBarView(
                          children: [LoginTab(), CreateAccountTab()],
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
