import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/common/colors.dart';
import 'package:news_app/common/common.dart';
import 'package:news_app/common/widgets/no_connectivity.dart';
import 'package:news_app/screens/home/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    if (await getInternetStatus()) {
      Timer(const Duration(seconds: 2), () {
        // Navigate to the home screen after 2 seconds
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      });
    } else {
      Navigator.of(context, rootNavigator: true)
          .push(
            MaterialPageRoute(
              builder: (context) => const NoConnectivity(),
            ),
          )
          .then(
            (value) => checkConnectivity(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.tertiary,
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.40,
              ),
                Text(
                "News App",
                style: GoogleFonts.poppins(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                ),
              SizedBox(
                height: size.height * 0.3,
              ),
              Text(
                "For CodeChef-VIT",
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
