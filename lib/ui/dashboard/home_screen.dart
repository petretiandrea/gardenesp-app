import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/blocs/garden/garden_cubit.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/model/Garden.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:gardenesp/routes.dart';
import 'package:gardenesp/ui/dashboard/gardens_list.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key? key, required this.name}) : super(key: key);

  final GardenRepository repo = GardenRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: BlocProvider(
          create: (ctx) => GardenCubit(
              ctx.read<GardenRepository>(), ctx.read<UserRepository>())
            ..loadGardens(),
          child: BlocBuilder<GardenCubit, ResourceState<List<Garden>>>(
            builder: (context, state) {
              if (state is ResourceSuccess<List<Garden>>) {
                return RefreshIndicator(
                  child: GardensList(
                    gardens: state.value,
                    onItemSelected: (selectedItem) {
                      print("Item $selectedItem");
                    },
                  ),
                  onRefresh: () async =>
                      context.read<GardenCubit>()..loadGardens(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.isAuthenticated)
                _buildHeader(context, state.as<Authenticated>().user),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Text('Home'),
                      leading: Icon(Icons.home),
                    ),
                    ListTile(
                      title: Text('Calendario Programmazione'),
                      leading: Icon(Icons.calendar_today),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
                child: Text("LOGOUT"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, User user) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCircleAvatar(user),
                ElevatedButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.PROFILE_DETAIL_EDIT);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    elevation: 0,
                  ),
                ),
              ],
            ),
            if (user.displayName != null) Text(user.displayName),
            Text(user.email),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(User user) {
    return user.photoURL != null
        ? CircleAvatar(
            child: Image(
              image: Image.network(user.photoURL).image,
            ),
          )
        : CircleAvatar(
            radius: 40,
            child: Text(
              user.email[0].toUpperCase(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          );
  }
}
