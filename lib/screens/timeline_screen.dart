import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineScreen extends StatefulWidget {
  final List<dynamic> data;

  const TimelineScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Image.asset('assets/images/appbar.png', height: 25),
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: widget.data.map((item) {
              final startDate =
                  DateFormat('HH:mm').format(DateTime.parse(item['startDate']));
              final endDate =
                  DateFormat('HH:mm').format(DateTime.parse(item['endDate']));
              final matkulType = item['matkul']['tipeMatkul'];

              Color containerColor =
                  matkulType == 'Teori' ? Colors.blue : Colors.yellow;

              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: containerColor,
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${item['matkul']['namaMatkul']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 35,
                      left: 0,
                      child: Text(
                        'Ruang: ${item['ruang']['nama']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      left: 0,
                      child: Text(
                        '$startDate - $endDate',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add functionality for the button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        child: const Text('Presensi'),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.3,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                widget.data.length,
                (index) => Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: index == _currentIndex ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
