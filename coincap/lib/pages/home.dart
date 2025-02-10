import 'dart:convert';

import 'package:coincap/pages/crypto_list.dart';
import 'package:coincap/service/web.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? width, height;
  WebService? webService;
  String coinSelect = "Solana";

  @override
  void initState() {
    super.initState();
    webService = GetIt.instance.get<WebService>();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CoinCap Crypto'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dropdown(),
              coinData(),
            ],
          ),
        ),
      ),
    );
  }

// dropdown selection
  Widget dropdown() {
    List<String> coins = [
      'Bitcoin',
      'Ethereum',
      'Litecoin',
      'Dogecoin',
      'Solana',
      'Worldcoin',
      'Ripple',
      'Cardano',
    ];
    List<DropdownMenuItem<String>> coinItem = coins
        .map((coin) => DropdownMenuItem(
              value: coin,
              child: Text(
                coin,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
        .toList();

    return DropdownButton(
      items: coinItem,
      value: coinSelect,
      onChanged: (dynamic coin) {
        setState(() {
          coinSelect = coin;
        });
      },
      dropdownColor: Theme.of(context).colorScheme.surface,
      iconSize: 25,
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  // coin data
  Widget coinData() {
    return FutureBuilder(
      future: webService!.getData('coins/${coinSelect.toLowerCase()}'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map coinData = jsonDecode(snapshot.data.toString());
          coinData.forEach(
            (key, value) {
              print("\n$key: $value");
            },
          );
          coinData.forEach((key, value) {
            print(key);
          });
          num coinPrice = coinData['market_data']['current_price']['usd'];
          num coinChange =
              coinData['market_data']['price_change_percentage_24h'];
          Map exchangeRates = coinData['market_data']['current_price'];

          print(coinData['market_data']);

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentPrice(coinPrice),
              GestureDetector(
                child: cryptoLogo(coinData['image']['large']),
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext contextCompare) {
                        return PriceCompare(coinRates: exchangeRates, coinSelect: coinSelect,);
                      },
                    ),
                  );
                },
              ),
              changeRate(coinChange),
              coinDescription(coinData['description']['en']),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  // coin price, logo and change rate
  Widget currentPrice(num rate) {
    return Text(
      '${rate.toStringAsFixed(2)} US Dollars',
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800,),
    );
  }

  Widget changeRate(num rate) {
    return Text(
      ' Rate change: ${rate.toStringAsFixed(2)} %',
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,),
    );
  }

  Widget cryptoLogo(String imageUrl) {
    return CircleAvatar(
      radius: width! * 0.25,
      backgroundImage: NetworkImage(imageUrl),
    );
  }

  //coin description
  Widget coinDescription(String description) {
    return Container(
      width: width! * 0.875,
      height: height! * 0.425,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(width! * 0.05),
      child: Text(
        description,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        softWrap: true,
      ),
    );
  }
}
