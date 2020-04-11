import 'package:http/http.dart';
import 'dart:convert';

class CardImage {
  int id;
  String imageUrl;
  String imageUrlSmall;

  CardImage({this.id, this.imageUrl, this.imageUrlSmall});

  factory CardImage.fromJson(dynamic json) {
    return CardImage(
        id: json['id'] as int,
        imageUrl: json['image_url'] as String,
        imageUrlSmall: json['image_url_small'] as String);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$id $imageUrlSmall $imageUrl';
  }
}

class CardSet {
  String setName;
  String setCode;
  String setRarity;
  String setPrice;
  CardSet({this.setName, this.setCode, this.setRarity, this.setPrice});

  factory CardSet.fromJson(dynamic json) {
    return CardSet(
        setCode: json['set_code'] as String,
        setName: json['set_name'] as String,
        setPrice: json['set_price'] as String,
        setRarity: json['set_rarity'] as String);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$setName $setCode $setRarity $setPrice';
  }
}

class YugiohCard {
  int id;
  String name;
  String type;
  String desc;
  String race;
  String archetype;
  List<CardSet> cardSets;
  List<CardImage> cardImages;
  List<String> cardPrices;

  YugiohCard(
      {this.id,
      this.name,
      this.type,
      this.desc,
      this.race,
      this.archetype,
      this.cardSets,
      this.cardImages,
      this.cardPrices});

  factory YugiohCard.fromJson(dynamic json) {
    var setsObjsJson = json['card_sets'] as List;
    List<CardSet> _cardSets = setsObjsJson != null
        ? setsObjsJson.map((setJson) => CardSet.fromJson(setJson)).toList()
        : null;

    var imagesObjsJson = json['card_images'] as List;
    List<CardImage> _cardImages = imagesObjsJson != null
        ? imagesObjsJson
            .map((imageJson) => CardImage.fromJson(imageJson))
            .toList()
        : null;

    return YugiohCard(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      desc: json['desc'] as String,
      race: json['race'] as String,
      archetype: json['archetype'] as String,
      cardSets: _cardSets,
      cardImages: _cardImages,
      //cardPrices:
    );
  }

  Future<List<YugiohCard>> getAllCardsNetworkData() async {
    Response response =
        await get('https://db.ygoprodeck.com/api/v6/cardinfo.php');
    //Response response = await get('https://db.ygoprodeck.com/api/v6/cardinfo.php?name=Dark%20Magician');
    String jsonObj = response.body;

    var cardsObjsJson = jsonDecode(jsonObj) as List;
    List<YugiohCard> cardObjs =
        cardsObjsJson.map((cardJson) => YugiohCard.fromJson(cardJson)).toList();

    //cardObjs.forEach((element) {print(element.toString());});

    return cardObjs;
  }

  Future<List<YugiohCard>> searchCardsByName(String name) async {
    Response response =
        await get('https://db.ygoprodeck.com/api/v6/cardinfo.php?fname=$name');
    String jsonObj = response.body;

    var cardsObjsJson = jsonDecode(jsonObj) as List;
    List<YugiohCard> cardObjs =
        cardsObjsJson.map((cardJson) => YugiohCard.fromJson(cardJson)).toList();

    //cardObjs.forEach((element) {print(element.toString());});

    return cardObjs;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name $name ${cardSets.toString()} ${cardImages.toString()}';
  }

  // Future<void> getTime() async{

  //   try{
  //     Response response = await get('http://worldtimeapi.org/api/timezone/$locationUrl');
  //     Map timeData = jsonDecode(response.body);
  //     //print(timeData);

  //     String dateTime = timeData['datetime'];
  //     String offset = timeData['utc_offset'].substring(1,3);

  //     //print('$dateTime - $offset');

  //     DateTime now = DateTime.parse(dateTime);
  //     now = now.add(Duration(hours: int.parse(offset)));

  //     time = DateFormat.jm().format(now);

  //     isDayTime = now.hour>6 && now.hour<20 ? true : false;

  //   }catch(e){
  //     print('caught error: $e');
  //     time = 'could not get time';
  //   }

  //   //print(now);
  // }
}
