import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/garden/garden_cubit.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/model/garden.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:gardenesp/routes.dart';
import 'package:gardenesp/ui/dashboard/gardens_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Dashboard'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.GARDEN_CREATE_EDIT_SCREEN);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (ctx) => GardenCubit(
              ctx.read<GardenRepository>(), ctx.read<UserRepository>())
            ..loadGardens(),
          child: _buildGardenList(),
        ),
      ),
    );
  }

  Widget _buildGardenList() {
    return BlocBuilder<GardenCubit, ResourceState<List<Garden>>>(
      builder: (context, state) {
        if (state is ResourceSuccess<List<Garden>>) {
          return RefreshIndicator(
            child: GardensList(
              gardens: state.value,
              onItemSelected: (selectedItem) {
                print("Item $selectedItem");
              },
            ),
            onRefresh: () => context.read<GardenCubit>().loadGardens(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
