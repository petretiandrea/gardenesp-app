import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/login/form_submission_status.dart';
import 'package:gardenesp/blocs/login/login_form_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormCubit, LoginFormState>(
      listener: (context, state) {
        if (state.formState is FormSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Authentication Failure")),
            );
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _emailTextField(context),
                _passwordTextField(context),
                _loginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginFormCubit>().emailChanged(value),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: !state.validEmail ? 'invalid email' : null,
          ),
        );
      },
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginFormCubit>().passwordChanged(value),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText: !state.validPassword ? 'invalid password' : null,
          ),
        );
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        return state.formState is FormSubmissionLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () =>
                    context.read<LoginFormCubit>().loginWithCredentials(),
                child: Text("Login"),
              );
      },
    );
  }
}
