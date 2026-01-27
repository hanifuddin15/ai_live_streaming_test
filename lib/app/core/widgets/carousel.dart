// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class PrimarCarousel extends StatelessWidget {
//   final CarouselSliderController carouselController;
//   final List<Widget> itemList;
//   final double height;

//   const PrimarCarousel({
//     super.key,
//     required this.carouselController,
//     required this.itemList,
//     required this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       carouselController: carouselController,
//       options: CarouselOptions(
//         viewportFraction: 1.0,
//         enlargeCenterPage: true,
//         height: height,
//         aspectRatio: 16 / 9,
//         scrollPhysics: const NeverScrollableScrollPhysics(),
//         initialPage: 0,
//         enableInfiniteScroll: true,
//         reverse: false,
//         autoPlay: false,
//         autoPlayInterval: const Duration(seconds: 3),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enlargeFactor: 0.3,
//         scrollDirection: Axis.horizontal,
//       ),
//       items: itemList,
//     );
//   }
// }
