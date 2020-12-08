import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'services/coin_data.dart';
import 'dart:io' show Platform;
import 'components/exchange_rate_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<String> exchangeRate = ['?', '?', '?'];

  void initState() {
    super.initState();

    updateExchangeRate();
  }

  CupertinoPicker getIOSPicker() {
    List<Text> itemList = [];

    for (String currency in currenciesList) {
      itemList.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          this.selectedCurrency = currenciesList[selectedIndex];
        });

        updateExchangeRate();
      },
      children: itemList,
    );
  }

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownList = [];

    // assemble list of dropdown items
    for (String currency in currenciesList) {
      dropdownList
          .add(DropdownMenuItem(child: Text(currency), value: currency));
    }

    return DropdownButton<String>(
      value: this.selectedCurrency,
      items: dropdownList,
      onChanged: (value) async {
        setState(() {
          this.selectedCurrency = value;
        });

        updateExchangeRate();
      },
    );
  }

  Widget getPicker() {
    if (Platform.isIOS)
      return getIOSPicker();
    else if (Platform.isAndroid)
      return getAndroidDropdown();
    else
      return null;
  }

  Future<void> updateExchangeRate() async {
    for (int i = 0; i < 3; i++) {
      CoinData rate = CoinData(
        fromCurrency: cryptoList[i],
        toCurrency: this.selectedCurrency,
      );

      var exchangeData = await rate.getCoinData();

      if (exchangeData == null) {
        this.exchangeRate[i] = '?';
        return;
      }

      setState(() {
        this.exchangeRate = exchangeData['rate'].toStringAsFixed(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExchangeRateCard(
            exchangeRate: exchangeRate[0],
            fromCurrency: cryptoList[0],
            selectedCurrency: selectedCurrency,
          ),
          ExchangeRateCard(
            exchangeRate: exchangeRate[1],
            fromCurrency: cryptoList[1],
            selectedCurrency: selectedCurrency,
          ),
          ExchangeRateCard(
            exchangeRate: exchangeRate[2],
            fromCurrency: cryptoList[2],
            selectedCurrency: selectedCurrency,
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
