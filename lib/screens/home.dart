import 'package:flutter/material.dart';
import 'package:yugioh_cards/screens/card_item.dart';
import 'package:yugioh_cards/service/get_yugioh_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  bool _isSearching = false;
  String _searchQuery = '';
}

class _HomeScreenState extends State<HomeScreen> {
  List<YugiohCard> allCards;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    allCards =
        allCards != null ? allCards : ModalRoute.of(context).settings.arguments;

    //widget.allCards==null ? getYugiohCards() : null;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: widget._isSearching ? searchField() : Text('Yugioh Cards'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  widget._isSearching = !widget._isSearching;
                  print(widget._isSearching);
                });
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              child: Image.asset(
                'assets/card.jpg',
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 3.0,
              children: List.generate(allCards.length, (index) {
                return Center(
                  child: YugiohCardItem(yugiohCard: allCards[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // String getCardsString(List<YugiohCard> allCards) {
  //   StringBuffer stringBuffer = new StringBuffer();
  //   // allCards.forEach((element) {
  //   //   stringBuffer.write(element.toString());
  //   // });

  //   stringBuffer.write(allCards[0]);
  //   return stringBuffer.toString();
  // }

  Widget searchField() {
    return TextFormField(
      decoration: InputDecoration(
        
          hintText: 'Enter card title...',
          fillColor: Colors.black,
          filled: true,
          hintStyle: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0))),
      onEditingComplete: () {
        print(widget._searchQuery);
        searchYugiohCards(widget._searchQuery);
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: (val){
        widget._searchQuery = val;
      },
      style: TextStyle(
        color: Colors.white,
    ),
    );
  }

  void searchYugiohCards(String search) async {
    List<YugiohCard> cardResults;
    YugiohCard instance = YugiohCard();
    cardResults = await instance.searchCardsByName(search);

    Navigator.pushReplacementNamed(context, '/home', arguments: cardResults);

    //return allCards;

    // setState(() {
    //   widget.allCards.forEach((element) {print(element.toString());});
    // });
  }
}
