import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFullSun = false;
  bool isDayMood = true;
  Duration duration = const Duration(seconds: 5);

  Future<void> changeMood(int value) async {
    await Future.delayed(duration);
    if (value == 0) {
      setState(() {
        isFullSun = true;
      });
    } else {
      setState(() {
        isFullSun = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future<void>.delayed(duration);
      await changeMood(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      const Color(0xFF8c2480),
      const Color(0xFFCE587D),
      const Color(0xFFFF9485),
      if (isFullSun) const Color(0xFFFF9D80),
    ];

    List<Color> darkBgColors = [
      const Color(0xFF0D1441),
      const Color(0xFF283584),
      const Color(0xFF376AB2),
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        width: width,
        height: height,
        curve: Curves.easeInOut,
        duration: duration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isFullSun ? lightBgColors : darkBgColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isFullSun ? 360 : -190,
              duration: duration,
              child: SvgPicture.asset('assets/sun_svg.svg'),
            ),
            Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/land_tree_light.png',
                width: width,
                height: 430,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: width * 0.9,
              height: 60,
              margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: (value) async {
                    changeMood(value);
                  },
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: 'Day'),
                    Tab(text: 'Night'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
