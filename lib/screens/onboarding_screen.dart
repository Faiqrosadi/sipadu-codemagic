// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/screens/widget/t_rounded_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Image.asset('assets/images/appbar.png', height: 25),
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CarouselWithIndicator(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(textAlign: TextAlign.center,'Log in', style: TextStyle(fontWeight: FontWeight.w700),),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top:10, bottom: 20),child: Text('Aplikasi ini masih dalam tahap pengembangan', style: TextStyle(color: Colors.grey)),)
            ],
          ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({Key? key}) : super(key: key);

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: MediaQuery.of(context).size.height / 2.8,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: const [
            TRoundedImage(
              imageUrl: 'assets/images/onboard 2.png',
              heading: 'Pantau jadwal melalui widget',
              caption: 'Kamu bisa cek jadwal perkuliahan tanpa membuka browser atau aplikasi lagi',
            ),
            TRoundedImage(
              imageUrl: 'assets/images/onboard 1.png',
              heading: 'Presensi sekali klik',
              caption: 'Tandai Presensimu hanya melalui notifikasi',
            ),
            TRoundedImage(
              imageUrl: 'assets/images/onboard 3.png',
              heading: 'Semua Layanan dalam satu pintu',
              caption: 'Sipadu Mobile hadir untuk menggabungkan semua layanan akademik ke dalam satu tempat',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: 5.0,
              height: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
