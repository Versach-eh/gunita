import 'package:flutter/material.dart';
import 'package:gunita20/screens/landingpage_screen.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4b1dcb),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/whitelogo.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Gunita',
              style: TextStyle(
                fontSize:60,
                fontWeight: FontWeight.bold,
                color: Color(0xfffcfbfd), // Set the text color to dark purple
                fontFamily: 'MagdelinAlt-Text', // Set the font family
                fontStyle: FontStyle.normal, // Set the font style
              ),
            ),
            const Text(
              'Your all in one app for dementia care',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color(0xfff9f6f9), // Set the text color to white
                fontFamily: 'MagdelinAlt-Medium', // Set the font family
                fontStyle: FontStyle.normal, // Set the font style
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3b0d6b),
                  fontFamily: 'MagdelinAlt-Medium', // Set the font family
                fontStyle: FontStyle.normal, // Set the font style
                  // Set the font color to black
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
