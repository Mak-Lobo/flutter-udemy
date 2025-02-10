import 'package:flutter/material.dart';

class PriceCompare extends StatelessWidget {
  final Map coinRates;
  final String coinSelect;

  const PriceCompare(
      {required this.coinRates, super.key, required this.coinSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$coinSelect Price'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (_context, index) {
          return ListTile(
            title: Text(
              coinRates.keys.elementAt(index).toString().toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              coinRates.values.elementAt(index).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
