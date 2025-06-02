import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/weather/weather_page.dart';
import 'presentation/pages/profile/profile_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뉴스 피드 iOS 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF101014),
        cardColor: const Color(0xFF23242A),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF18191C),
          selectedItemColor: Colors.blue[300],
          unselectedItemColor: Colors.grey[500],
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const MainTabScaffold(),
    );
  }
}

class MainTabScaffold extends StatefulWidget {
  const MainTabScaffold({super.key});

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    WeatherPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '뉴스',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: '날씨',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
      ),
    );
  }
} 