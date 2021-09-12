import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/generated/l10n.dart';
import 'package:gardenesp/ui/dashboard/home_screen.dart';
import 'package:gardenesp/ui/profile/profile_screen.dart';
import 'package:gardenesp/ui/scheduling/schedule_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndexPage = 0;
  final _pages = [
    HomeScreen(),
    ScheduleScreen(),
    ProfileScreen(),
  ];
  final _navigationQueue = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty) return true;
        setState(() {
          _navigationQueue.removeLast();
          _currentIndexPage =
              _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
        });
        return false;
      },
      child: Scaffold(
        bottomNavigationBar:
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (_, current) => current.isAuthenticated,
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: _currentIndexPage,
              onTap: (index) {
                if (index != _currentIndexPage) {
                  _navigationQueue.removeWhere((element) => element == index);
                  _navigationQueue.add(index);
                  setState(() {
                    _currentIndexPage = index;
                  });
                }
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: S.of(context).navigation_dashboard_label,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: S.of(context).navigation_schedule_label,
                ),
                BottomNavigationBarItem(
                  icon: _buildCircleAvatar(
                    state.as<Authenticated>().user,
                  ),
                  label: S.of(context).navigation_profile_label,
                ),
              ],
            );
          },
        ),
        body: IndexedStack(
          children: _pages,
          index: _currentIndexPage,
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(User user) {
    return user.photoURL != null
        ? CircleAvatar(
            radius: 14,
            child: Image(
              image: Image.network(user.photoURL).image,
            ),
          )
        : CircleAvatar(
            radius: 14,
            child: Text(
              user.email[0].toUpperCase(),
            ),
          );
  }
}
