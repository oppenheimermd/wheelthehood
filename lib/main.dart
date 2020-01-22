import 'package:flutter/material.dart';
import 'package:wheelthehood/core/models/user.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/locator.dart';
import 'package:provider/provider.dart';
import 'package:wheelthehood/ui/views/root_view.dart';

void main() {
  //  call setupLocator before we run the app
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (context) => locator<AuthService>().getStreamController().stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter login demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootView(),
      ),
    );
  }
}
