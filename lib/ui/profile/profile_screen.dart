import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.PROFILE_DETAIL_EDIT);
              },
              child: Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Setting'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LoggedOut());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
