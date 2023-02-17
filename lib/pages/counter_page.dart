import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/count_provider.dart';

class MyCountPage extends StatelessWidget {
  const MyCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    CountProvider state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ChangeNotifierProvider example ',
              style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 50,
          ),
          Text(
            '${state.counterValue}',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Consumer<CountProvider>(
                builder: ((context, value, child) {
                  return IconButton(
                    onPressed: () => value.decrementCount(),
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  );
                }),
              ),
              IconButton(
                onPressed: () => state.incrementCount(),
                icon: const Icon(Icons.add),
                color: Colors.green,
              ),
            ],
          )
        ],
      )),
    );
  }
}
