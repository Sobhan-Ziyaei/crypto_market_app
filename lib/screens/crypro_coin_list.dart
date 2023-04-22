import 'package:crypto_market_app/data/constant/custom_color.dart';
import 'package:crypto_market_app/data/model/crypro.dart';
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
      body: ListView.builder(
        itemCount: cryptoList!.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(cryptoList![index].name),
              subtitle: Text(cryptoList![index].symbol),
              leading: SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    cryptoList![index].rank.toString(),
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cryptoList![index].priceUsd.toStringAsFixed(2),
                        ),
                        Text(
                          cryptoList![index].changePercent.toStringAsFixed(2),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: 50,
                        child: Center(
                            child: _getIconPercentChange(
                                cryptoList![index].changePercent))),
                  ],
                ),
              ));
        },
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
}
