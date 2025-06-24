import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/view_models/bloc/auth/auth_bloc.dart';
import 'package:recipehut/view_models/bloc/auth/auth_event.dart';
import 'package:recipehut/view_models/bloc/auth/auth_state.dart';
import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
import 'package:recipehut/view_models/bloc/home/home_event.dart';
import 'package:recipehut/views/home/home_page.dart';

class LoginPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) {
                  context.read<HomeBloc>().add(FetchAllRecipes());
                  return HomePage(user: state.user); // pass user
                },
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(labelText: 'Email')),
                TextField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          LoginRequested(emailCtrl.text, passwordCtrl.text),
                        );
                  },
                  child: state is AuthLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Login"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
