import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double radius = 125;
  final Tween<double> scale = Tween<double>(begin: 0, end: 1.0);

  // controliing the animation of a widget
  AnimationController? animateWidget;

  // starting animation upon app initilization
  @override
  void initState() {
    super.initState();
    animateWidget = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animateWidget!.repeat(); // starting the animation upon initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _animateButton(),
              iconAnimation(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return TweenAnimationBuilder(
      curve: Curves.easeOutExpo,
      duration: const Duration(seconds: 2),
      tween: scale,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 92, 121),
              Color.fromARGB(255, 207, 92, 121),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animateButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            radius += radius >= 125 ? -75 : 150;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutQuart,
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: Colors.deepOrange[300],
            borderRadius: BorderRadius.circular(radius - 25),
          ),
          child: Center(
            child: Text(
              'Animate',
              style: TextStyle(
                color: Colors.black,
                fontSize: radius / 5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //utilizing the animation controller to animate the widget
  Widget iconAnimation() {
    return AnimatedBuilder(
      animation: animateWidget!.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: animateWidget!.value * 6.3,
          child: child,
        );
      },
      child: const Icon(
        Icons.currency_bitcoin_rounded,
        color: Color.fromARGB(169, 6, 130, 168),
        size: 100,
      ),
    );
  }
}
