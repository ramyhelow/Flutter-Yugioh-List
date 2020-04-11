import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugioh_cards/service/get_yugioh_cards.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    getYugiohCards();
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: SpinKitPouringHourglass(
            color: Colors.white,
            size: 80.0,
          ),
        ));
  }
 
 void getYugiohCards() async {
    List<YugiohCard> allCards;
    YugiohCard instance = YugiohCard();
    allCards = await instance.getAllCardsNetworkData();

    Navigator.pushReplacementNamed(context, '/home', arguments: allCards);

    //return allCards;

    // setState(() {
    //   widget.allCards.forEach((element) {print(element.toString());});
    // });
  }
}
