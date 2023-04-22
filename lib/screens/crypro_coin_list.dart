import 'package:crypto_market_app/data/constant/custom_color.dart';
import 'package:crypto_market_app/data/model/crypro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryptoCoinList extends StatefulWidget {
  CryptoCoinList({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  State<CryptoCoinList> createState() => _CryptoCoinListState();
}

class _CryptoCoinListState extends State<CryptoCoinList> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColor.blackColor,
        title: Text(
          'بازار  کریپتو',
          style: TextStyle(fontFamily: 'morabaee'),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: CustomColor.blackColor,
      body: SafeArea(
          child: RefreshIndicator(
        backgroundColor: CustomColor.greenColor,
        color: CustomColor.blackColor,
        onRefresh: () async {
          List<Crypto> fereshData = await _getData();
          setState(() {
            cryptoList = fereshData;
          });
        },
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) {
            return _getItemList(cryptoList![index]);
          },
        ),
      )),
    );
  }

  Widget _getItemList(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: CustomColor.greenColor),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: CustomColor.greyColor),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: CustomColor.greyColor),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(color: CustomColor.greyColor, fontSize: 18),
                ),
                Text(
                  crypto.changePercent.toStringAsFixed(2),
                  style: TextStyle(
                    color: _getChangeColorText(crypto.changePercent),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 50,
                child:
                    Center(child: _getIconPercentChange(crypto.changePercent))),
          ],
        ),
      ),
    );
  }

  Widget _getIconPercentChange(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: CustomColor.redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: CustomColor.greenColor,
          );
  }

  Color _getChangeColorText(double percentChange) {
    return percentChange <= 0 ? CustomColor.redColor : CustomColor.greenColor;
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList()
        .cast<Crypto>();
    return cryptoList;
  }
}
