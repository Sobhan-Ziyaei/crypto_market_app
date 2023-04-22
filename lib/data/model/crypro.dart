class Crypto {
  String id;
  String name;
  int rank;
  String symbol;
  double priceUsd;
  double changePercent;
  double marketCapUsd;

  Crypto(this.id, this.name, this.rank, this.symbol, this.priceUsd,
      this.marketCapUsd, this.changePercent);



  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject['id'],
      jsonMapObject['name'],
      int.parse(jsonMapObject['rank']),
      jsonMapObject['symbol'],
      double.parse(jsonMapObject['priceUsd']),
      double.parse(jsonMapObject['changePercent24Hr']),
      double.parse(jsonMapObject['marketCapUsd']),
    );
  }
}