import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../root/root_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: SvgPicture.asset('assets/icons/LOGO.svg', width: 120),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.primary,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: TabBar(
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          labelColor: themeData.colorScheme.onPrimary,
                          unselectedLabelColor:
                          themeData.colorScheme.onPrimary.withAlpha(153),
                          indicatorColor: themeData.colorScheme.onPrimary,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'LOGIN'),
                            Tab(text: 'SIGN UP'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: const TabBarView(
                            children: [
                              _LoginForm(),
                              _SignUpForm(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// فیلد ورودی هوشمند با واکنش به حالت فوکوس
class _AppTextField extends StatefulWidget {
  const _AppTextField({
    required this.label,
    required this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
  });

  final String label;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<_AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<_AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final activeColor = themeData.colorScheme.primary;
    final idleColor = themeData.colorScheme.primary.withAlpha(153);
    final iconColor = _isFocused ? activeColor : idleColor;

    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.isPassword && !_passwordVisible,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: themeData.textTheme.titleMedium?.copyWith(color: iconColor),
        filled: true,
        fillColor: _isFocused ? const Color(0xffEDF1FB) : const Color(0xffF4F6FC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: activeColor, width: 1.5),
        ),
        prefixIcon: Icon(widget.prefixIcon, color: iconColor),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _passwordVisible
                ? CupertinoIcons.eye_slash
                : CupertinoIcons.eye,
            color: iconColor,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        )
            : null,
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // نکته: قبلاً `onPressed: () {}` بود — یعنی دکمه LOGIN هیچ کاری انجام
  // نمی‌داد و کاربر هرگز نمی‌توانست از AuthScreen به RootScreen (تب‌های
  // اصلی اپ: Home/Article/Search/Menu) برسد. چون بک‌اند واقعی وجود
  // ندارد، اینجا فقط یک اعتبارسنجی سبک (خالی‌نبودن فیلدها) انجام
  // می‌دهیم و در صورت موفقیت به RootScreen می‌رویم.
  void _submit() {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your username and password')),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(36, 50, 36, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back', style: themeData.textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Sign in with your account',
            style: themeData.textTheme.titleLarge?.apply(fontSizeFactor: 0.9) ??
                themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          _AppTextField(
            controller: _usernameController,
            label: 'Username',
            prefixIcon: CupertinoIcons.person,
          ),
          const SizedBox(height: 16),
          _AppTextField(
            controller: _passwordController,
            label: 'Password',
            prefixIcon: CupertinoIcons.lock,
            isPassword: true,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text(
                'LOGIN',
                style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot your password?',
                style: themeData.textTheme.bodyMedium,
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {},
                child: const Text('Reset here'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const _OrDivider(),
          const SizedBox(height: 16),
          const _SocialButtons(),
        ],
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // همان مشکل فرم لاگین: دکمه SIGN UP قبلاً هیچ کاری نمی‌کرد.
  void _submit() {
    final email = _emailController.text.trim();

    if (_usernameController.text.trim().isEmpty ||
        email.isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(36, 50, 36, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create Account', style: themeData.textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Sign up and start reading',
            style: themeData.textTheme.titleLarge?.apply(fontSizeFactor: 0.9) ??
                themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          _AppTextField(
            controller: _usernameController,
            label: 'Username',
            prefixIcon: CupertinoIcons.person,
          ),
          const SizedBox(height: 16),
          _AppTextField(
            controller: _emailController,
            label: 'Email',
            prefixIcon: CupertinoIcons.envelope,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _AppTextField(
            controller: _passwordController,
            label: 'Password',
            prefixIcon: CupertinoIcons.lock,
            isPassword: true,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text(
                'SIGN UP',
                style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const _OrDivider(),
          const SizedBox(height: 16),
          const _SocialButtons(),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final lineColor = themeData.colorScheme.onSurface.withAlpha(26);

    return Row(
      children: [
        Expanded(child: Divider(color: lineColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR SIGN IN WITH',
            style: themeData.textTheme.bodySmall?.copyWith(letterSpacing: 2),
          ),
        ),
        Expanded(child: Divider(color: lineColor)),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _SocialButton(
          asset: 'assets/icons/Google.png',
          label: 'Google',
        ),
        SizedBox(width: 24),
        _SocialButton(
          asset: 'assets/icons/Facebook.png',
          label: 'Facebook',
        ),
        SizedBox(width: 24),
        _SocialButton(
          asset: 'assets/icons/Twitter.png',
          label: 'Twitter',
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.asset,
    required this.label,
    this.onTap,
  });

  final String asset;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(asset, width: 36, height: 36),
        ),
      ),
    );
  }
}
