import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ✅ Top-level helper widgets
Widget fieldLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryDark,
      ),
    ),
  );
}

Widget inputField({
  required String hint,
  bool isPassword = false,
  Widget? suffixIcon,
}) {
  return TextField(
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 179, 174, 174)),
      filled: true,
      fillColor: AppTheme.fieldBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.primaryGreen),
      ),
      suffixIcon: suffixIcon,
    ),
  );
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Sign up to continue !',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: AppTheme.primaryDark,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Create an account to get all features',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: AppTheme.gray,
                    ),
              ),
              const SizedBox(height: 24),

              // First + Last name
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel('First Name'),
                        inputField(hint: 'Enter first name'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel('Last Name'),
                        inputField(hint: 'Enter last name'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Email
              fieldLabel('Email'),
              inputField(hint: 'Enter email address'),
              const SizedBox(height: 20),

              // Password
              fieldLabel('Password'),
              inputField(
                hint: 'Enter password',
                isPassword: true,
                suffixIcon: const Icon(
                  Icons.visibility_outlined,
                  color: AppTheme.gray,
                ),
              ),
              const SizedBox(height: 30),

              // Sign Up button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // -------- OR DIVIDER --------
              const Row(
                children: [
                  Expanded(
                    child: Divider(color: AppTheme.borderColor, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: TextStyle(color: AppTheme.gray)),
                  ),
                  Expanded(
                    child: Divider(color: AppTheme.borderColor, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // -------- SOCIAL BUTTONS (FINAL FIXED VERSION) --------
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppTheme.borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(image: AssetImage('assets/images/google.png'), width: 22, height: 22),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Google',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppTheme.borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.facebook, color: Colors.blue, size: 28),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Facebook',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // -------- FOOTER TEXT --------
              Center(
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: AppTheme.gray, fontSize: 13),
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: AppTheme.gray, fontSize: 13),
                        children: [
                          TextSpan(text: 'By continuing, you fully agree to our '),
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}