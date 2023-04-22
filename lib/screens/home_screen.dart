import 'package:crypto_market_app/constant/color.dart';
import 'package:crypto_market_app/data/model/crypro.dart';
import 'package:crypto_market_app/screens/crypro_coin_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.blackColor,
      body: SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }

  void getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList()
        .cast<Crypto>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CryptoCoinList(
            cryptoList: cryptoList,
          );
        },
      ),
    );
  }
}
