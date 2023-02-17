import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<int>(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('StreamProvider Example', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 50),
        Text('$value', style: Theme.of(context).textTheme.headline4)
      ],
    ));
  }
}
