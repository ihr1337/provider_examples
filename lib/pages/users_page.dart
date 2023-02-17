import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class MyUsersPage extends StatelessWidget {
  const MyUsersPage({Key? key}) : super(key: key);

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
