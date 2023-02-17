import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
                  Tab(
                    icon: Icon(Icons.add),
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                  ),
                  Tab(
                    icon: Icon(Icons.message),
                  ),
                ]),
              ),
              body: const TabBarView(children: [
                MyCountPage(),
                MyUserPage(),
                MyEventPage(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

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
                    onPressed: () => value._decrementCount(),
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  );
                }),
              ),
              IconButton(
                onPressed: () => state._incrementCount(),
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

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureProvider Example, users loaded from a File',
              style: TextStyle(fontSize: 17)),
        ),
        Consumer(builder: (context, List<User>? users, _) {
          return SizedBox(
            child: users == null
                ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 50,
                          color: Colors.grey[(index * 200) % 400],
                          child: Center(
                              child: Text(
                                  '${users[index].firstName} ${users[index].lastName} | ${users[index].website}')));
                    },
                  ),
          );
        })
      ],
    );
  }
}

// Event page (counting)
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

// CountProvider (ChangeNotifier)
class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get counterValue => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}

// UserProvider (Future)
class UserProvider {
  final String _dataPath = "assets/users.json";
  List<User> users = [];

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    return users;
  }
}

// EventProvider (Stream)
class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 1);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}

// User Model
class User {
  final String firstName, lastName, website;
  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

// User List Model
class UserList {
  final List<User> users;
  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}
