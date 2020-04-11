import 'package:flutter/material.dart';
import 'package:yugioh_cards/screens/card_image_widget.dart';
import 'package:yugioh_cards/service/get_yugioh_cards.dart';

class YugiohCardItem extends StatefulWidget {
  //const 
  YugiohCardItem({Key key, this.yugiohCard}) : super(key: key);
  final YugiohCard yugiohCard;

  @override
  _YugiohCardItemState createState() => _YugiohCardItemState();
}

class _YugiohCardItemState extends State<YugiohCardItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text(
                      widget.yugiohCard.name,
                      textAlign: TextAlign.center,
                    ),
                    content: CardImageWidget(cardImages: widget.yugiohCard.cardImages,)
                  ));
        },
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/giphy.gif',
          image: widget.yugiohCard.cardImages[0].imageUrlSmall,
        ),
      ),
    );
  }
}
