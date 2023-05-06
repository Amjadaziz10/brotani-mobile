import 'package:brotani/home/land/land_list.dart';
import 'package:brotani/home/notification/notification.dart';
import 'package:brotani/home/notification/notification_list.dart';
import 'package:brotani/home/profile/change_password.dart';
import 'package:brotani/home/profile/profile.dart';
import 'package:brotani/shared/colors.dart';
import 'package:brotani/shared/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'land/land.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PanelController pcPassword = PanelController();
  bool navBar123 = true;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> appBarTitle = ['Daftar Lahan', 'Notifikasi', 'Profil'];
    List<Widget> _widgetOptions = <Widget>[
      LandList(lands: landList),
      NotificationList(notifs: notifList),
      ProfilePage(panel: pcPassword),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _selectedIndex == 2 ? Color(0xFF8FE8B2) : Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          appBarTitle[_selectedIndex],
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 24,
              ),
        ),
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: FarmSearchDelegate(),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.search),
                )
              ]
            : null,
      ),
      body: SlidingUpPanel(
        controller: pcPassword,
        backdropEnabled: true,
        maxHeight: 550.0,
        minHeight: 0,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        panel: ChangePasswordPanel(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: navBar123
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.leaf),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidBell),
                      label: 'Notification',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.circleUser),
                      label: 'School',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: greenBold,
                  onTap: _onItemTapped,
                ),
              ),
            )
          : null,
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addland');
              },
              child: Icon(
                FontAwesomeIcons.plus,
                color: white,
                size: 30,
              ),
              backgroundColor: greenBold)
          : null,
    );
  }
}

class FarmSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    for (int i = 0; i < landList.length; i++) landList[i].name
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var land in searchTerms) {
      if (land.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(land);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var land in searchTerms) {
      if (land.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(land);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
