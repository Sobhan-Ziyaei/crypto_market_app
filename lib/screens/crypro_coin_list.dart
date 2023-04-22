import 'package:crypto_market_app/data/model/crypro.dart';
import 'package:flutter/material.dart';


class CryptoCoinList extends StatefulWidget {
  CryptoCoinList({Key? key,this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList ;
  @override
  State<CryptoCoinList> createState() => _CryptoCoinListState();
}

class _CryptoCoinListState extends State<CryptoCoinList> {
  List<Crypto>? cryptoList ;
  @override
  void initState() {
    super.initState();
    cryptoList= widget.cryptoList ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: cryptoList!.length,
        itemBuilder: (context, index) {
          return Text(cryptoList![index].name);
        },
      ),
    );
  }
}