import 'package:flutter/material.dart';
import 'calculator.dart';
import 'weatherapp.dart';
import 'notes.dart';
import 'Greetings.dart';

//Comment Your Code’s Functions and Classes
void main() {
  runApp(const MyApp());
}

// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp configuration with theme and home page
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

// State class for the Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GreetingsPage(),
    const CalculatorPage(),
    const WeatherPage(),
    const NotesPage(),
     // Added GreetingsPage to the list
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold configuration with app bar, body, and bottom navigation bar
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: TextStyle(color: Colors.white70),
      ),
        backgroundColor: Theme.of(context).primaryColor,
        // Set the text color
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey, //unselected item color
        selectedItemColor: Colors.deepPurple, // Selected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Greetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),

        ],
      ),
    );
  }
}
