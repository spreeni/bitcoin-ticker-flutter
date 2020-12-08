import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

final String apiKey = DotEnv().env['APIKEY'];
const String coinAPI_URL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  CoinData({this.fromCurrency, this.toCurrency});

  String fromCurrency;
  String toCurrency;

  Future<dynamic> getCoinData() async {
    Map<String, String> header = {'X-CoinAPI-Key': apiKey};
    print('$coinAPI_URL/$fromCurrency/$toCurrency');
    print(apiKey);
    NetworkHelper networker = NetworkHelper(
      url: '$coinAPI_URL/$fromCurrency/$toCurrency',
      headers: header,
    );

    var exchangeData = await networker.getData();

    return exchangeData;
  }
}
