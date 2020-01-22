
import 'package:flutter/material.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/home_model.dart';
import 'package:wheelthehood/locator.dart';
import 'package:wheelthehood/ui/views/base_view.dart';
import 'package:wheelthehood/ui/views/chat_view.dart';
import 'package:wheelthehood/ui/views/dashboard_view.dart';
import 'package:wheelthehood/ui/views/groups_view.dart';
import 'package:wheelthehood/ui/views/profile_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({this.onSignedOut, Key key}) : super(key: key);
  final VoidCallback onSignedOut;

  @override
  _HomeViewState createState() => _HomeViewState(onSignedOut: onSignedOut);
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  final VoidCallback onSignedOut;
  final AuthService authService = locator<AuthService>();

  _HomeViewState({this.onSignedOut});

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await authService.signOut(context);
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        builder: (context, model, child) =>Scaffold(
          appBar: AppBar(
            title: Text('Dashbord'),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () => _signOut(context),
              )
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              DashboardView(),
              ChatPageView(),
              GroupsView(),
              ProfileView()
            ],
          ),
          bottomNavigationBar: Material(
            color: Colors.teal,
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home),),
                Tab(icon: Icon(Icons.chat),),
                Tab(icon: Icon(Icons.group),),
                Tab(icon: Icon(Icons.person),)
              ],
            ),
          ),
        )
    );
  }
}

