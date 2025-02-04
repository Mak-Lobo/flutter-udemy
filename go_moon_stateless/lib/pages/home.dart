import 'package:flutter/material.dart';
import 'package:go_moon_stateless/custom/dropdown.dart';

class HomePage extends StatelessWidget {
  // device dimension variables
  late double _height, _width;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.symmetric(horizontal: _width * 0.075),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _homeTitle(),
                  _booking(),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _imageBack(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // image background function
  Widget _imageBack() {
    return Container(
      height: _height * 0.5,
      width: _width * 0.65,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/astro.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // text function
  Widget _homeTitle() {
    return const Text(
      '#GoMoon',
      style: TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  // droppdown function
  Widget _destDropdown() {
    return CustomDropDown(
      items: const ['James Webb Telescope', 'SpaceX'],
      width: _width,
    );
  }

  Widget _travellerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomDropDown(
          items: const ['1', '2', '3', '4'],
          width: _width * 0.4,
        ),
        SizedBox(width: _width * 0.05),
        CustomDropDown(
          items: const ['Economy', 'Business', 'Private', 'First'],
          width: _width * 0.4,
        ),
      ],
    );
  }

  // booking area
  Widget _booking() {
    return Container(
      height: _height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _destDropdown(),
          _travellerInfo(),
          _bookButton(),
        ],
      ),
    );
  }

  Widget _bookButton() {
    return Container(
      margin: EdgeInsets.only(bottom: _height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: _width * 0.75,
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          'Book Now',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
