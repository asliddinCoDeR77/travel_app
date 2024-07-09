import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permissions/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(60),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Sign in now',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  const Gap(30),
                  const Text(
                    'Please sign in to continue our app',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Gap(30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      constraints:
                          const BoxConstraints(maxWidth: 390, maxHeight: 56),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const Gap(30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      hintStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF7F7F9)),
                          borderRadius: BorderRadius.circular(14)),
                      constraints:
                          const BoxConstraints(maxWidth: 390, maxHeight: 56),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget Password',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        minimumSize: const Size(390, 56)),
                    onPressed: () {},
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '''Don't have an account?''',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                          },
                          child: const Text(
                            'Sign up',
                            style: const TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                  const Text(
                    'Or connect',
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.all(104.0),
                    child: Image.asset('assets/images/with.png'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
