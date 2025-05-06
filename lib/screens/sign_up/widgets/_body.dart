part of '../sign_up.dart';

class _Body extends StatelessWidget {
  _Body();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Sign Up Screen'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseUsersServices().createUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  AppRoutes.home.pushReplace(context);
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                AppRoutes.login.push(context);
              },
              child: Text('Tap to login '),
            ),
          ],
        ),
      ),
    );
  }
}
