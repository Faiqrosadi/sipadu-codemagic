import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'timeline_screen.dart';
import 'jadwal_screen.dart';
import 'profil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<dynamic> _data = [];
  bool _isLoading = true;
  bool _isMounted = false; // Add this variable

  @override
  void initState() {
    super.initState();
    _isMounted = true; // Set _isMounted to true when the widget is mounted
    fetchData();
  }

  @override
  void dispose() {
    _isMounted = false; // Set _isMounted to false when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    if (!_isMounted)
      return; // Check if the widget is still mounted before proceeding

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? '';

      final response = await http.get(
        Uri.parse(
            'https://api.sipadu.dev/jadwal/mahasiswa?interval=daily&moveBy=0'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (!_isMounted)
        return; // Check if the widget is still mounted before updating state

      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      if (!_isMounted)
        return; // Check if the widget is still mounted before updating state

      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $error');
    }
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return TimelineScreen(data: _data);
      case 1:
        return JadwalScreen();
      case 2:
        return ProfilScreen();
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
