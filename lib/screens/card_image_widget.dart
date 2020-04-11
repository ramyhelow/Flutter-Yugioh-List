import 'package:flutter/material.dart';
import 'package:yugioh_cards/service/get_yugioh_cards.dart';

class CardImageWidget extends StatefulWidget {
  CardImageWidget({Key key, this.cardImages}) : super(key: key);
  final List<CardImage> cardImages;
  int _currentIndex = 0;
  @override
  _CardImageWidgetState createState() => _CardImageWidgetState();
}

class _CardImageWidgetState extends State<CardImageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget._currentIndex =
              (widget._currentIndex + 1) % widget.cardImages.length;
          print(widget._currentIndex);
        });
      },
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/giphy.gif',
        image: widget.cardImages[widget._currentIndex].imageUrl,
      ),
    );
  }
}
