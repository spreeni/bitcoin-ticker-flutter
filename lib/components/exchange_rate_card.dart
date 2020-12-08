import 'package:flutter/material.dart';

class ExchangeRateCard extends StatelessWidget {
  const ExchangeRateCard({
    @required this.exchangeRate,
    @required this.fromCurrency,
    @required this.selectedCurrency,
  });

  final String exchangeRate;
  final String fromCurrency;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${this.fromCurrency} = ${this.exchangeRate} ${this.selectedCurrency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
