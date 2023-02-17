import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:example_udemy/exports.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider practice',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
          FutureProvider(
              create: (_) async => UserProvider().loadUserData(),
              initialData: const []),
          StreamProvider(
              create: (_) => EventProvider().intStream(), initialData: 0)
        ],
        child: DefaultTabController(
          length: 3,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Provider Demo'),
                centerTitle: true,
                bottom: const TabBar(tabs: [
                  Tab(icon: Icon(Icons.add)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.message)),
                ]),
              ),
              body: const TabBarView(children: [
                MyCountPage(),
                MyUsersPage(),
                MyEventPage(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
