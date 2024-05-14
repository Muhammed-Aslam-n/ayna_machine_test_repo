import 'package:ayna_machine_test/core/validators.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  ValueNotifier<bool> obscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: obscure,
          builder: (context, b, k) {
            return TextFormField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              controller: widget.controller,
              // cursorColor: isDark ? Colors.grey : Colors.black54,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscure.value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(.1),
                hintText: "Password",
                prefixIcon: const Icon(IconlyLight.lock, size: 20),
                suffixIcon: IconButton(
                  icon: obscure.value
                      ? const Icon(IconlyLight.hide)
                      : const Icon(IconlyLight.show),
                  onPressed: () {
                    obscure.value = !obscure.value;
                  },
                ),
                // prefixIconColor: isDark ? Colors.white : Colors.black87,
                // suffixIconColor: isDark ? Colors.white : Colors.black87,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              inputFormatters: [PasswordInputFormatter()],
              validator: (String? password) {
                if (password == null || password.isEmpty) {
                  return 'Password cannot be empty';
                }
                final invalidReason = password.invalidPasswordReason;
                if (invalidReason != null) {
                  return invalidReason;
                }
                return null;
              },
            );
          }),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      // cursorColor: isDark ? Colors.grey : Colors.black54,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(.1),
        hintText: "Email",
        prefixIcon: const Icon(
          IconlyLight.message,
        ),
        // prefixIconColor: isDark ? Colors.white : Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? username) {
        if (username == null || username.isEmpty) {
          return 'Email cannot be empty';
        }
        final invalidReason = username.invalidEmailReason;
        if (invalidReason != null) {
          return invalidReason;
        }
        return null;
      },
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  final String actionString;

  final void Function()? onPressed;

  const AuthButtonWidget(
      {super.key, this.onPressed, required this.actionString});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 3.0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Text(
          actionString,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
