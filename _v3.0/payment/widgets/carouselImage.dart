// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../model/card_model.dart';

class CarouselImage extends StatefulWidget {
  final List<CardModel> cards;
  final CarouselController cardController;
  const CarouselImage({
    Key? key,
    required this.cards,
    required this.cardController,
  }) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: widget.cardController,
          items: widget.cards.map((card) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(card.cardImage),
            );
          }).toList(),
          options: CarouselOptions(
              height: 170,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.55,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.cards.map((card) {
            int index = widget.cards.indexOf(card);
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? primaryColor : blackColorShade2,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
