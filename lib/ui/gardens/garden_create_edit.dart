import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/garden/garden_editor_cubit.dart';
import 'package:gardenesp/blocs/login/form_submission_status.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';

class GardenCreateEditScreen extends StatefulWidget {
  final String? gardenId;

  const GardenCreateEditScreen({Key? key, this.gardenId}) : super(key: key);

  @override
  _GardenCreateEditScreenState createState() => _GardenCreateEditScreenState();
}

class _GardenCreateEditScreenState extends State<GardenCreateEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  bool get isEditing => widget.gardenId != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GardenEditorCubit(
        context.read<GardenRepository>(),
        context.read<UserRepository>(),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: isEditing ? Text("Create new garden") : Text("Modify"),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    final cubit = context.read<GardenEditorCubit>();
                    if (isEditing)
                      cubit.submitEdit(widget.gardenId ?? "",
                          _nameController.text, _descriptionController.text);
                    else
                      cubit.submitCreation(
                          _nameController.text, _descriptionController.text);
                  },
                  icon: const Icon(Icons.check),
                )
              ],
            ),
            body: BlocListener<GardenEditorCubit, GardenEditorState>(
              listener: (context, state) {
                if (state.formStatus == FormSubmissionSuccess())
                  Navigator.of(context).pop();
              },
              child: _buildBody(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return BlocBuilder<GardenEditorCubit, GardenEditorState>(
      builder: (context, state) {
        if (state.formStatus is FormSubmissionLoading) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else {
          return Form(
            child: Column(
              children: [
                Text("Name"),
                TextFormField(
                  controller: _nameController,
                ),
                Text("Description"),
                TextFormField(
                  controller: _descriptionController,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
