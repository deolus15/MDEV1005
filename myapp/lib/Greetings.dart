import 'package:flutter/material.dart';

// Greetings Page Widget
class GreetingsPage extends StatelessWidget {
  const GreetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Scaffold configuration for the Greetings Page
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image for the Greetings Page
            Image.asset(
              'assets/images/greetings.jpg',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
            const Positioned(
              top: 100,
              child: Text(
                'Greetings to all',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70, // Set the text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
