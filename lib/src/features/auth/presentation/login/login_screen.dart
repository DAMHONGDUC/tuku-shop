import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import 'components/demo_account_card.dart';
import 'components/login_text_field.dart';
import 'login_controller.dart';

final _kLogoSize = SdSpacingV5.s64;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginController>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  // Pre-filled so a reviewer can sign straight back in after a logout.
  final _emailController = TextEditingController(text: DemoAccount.email);
  final _passwordController = TextEditingController(text: DemoAccount.password);
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<LoginController>().login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void _fillDemoAccount() {
    _emailController.text = DemoAccount.email;
    _passwordController.text = DemoAccount.password;
  }

  String? _fieldErrorText(LoginFieldError? error) => switch (error) {
    LoginFieldError.emailEmpty => context.loc.login_error_email_empty,
    LoginFieldError.emailInvalid => context.loc.login_error_email_invalid,
    LoginFieldError.passwordEmpty => context.loc.login_error_password_empty,
    null => null,
  };

  String _failureText(LoginFailureReason reason) => switch (reason) {
    LoginFailureReason.invalidCredentials =>
      context.loc.login_error_invalid_credentials,
    LoginFailureReason.unknown => context.loc.login_error_unknown,
  };

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state is LoginSuccessState) {
      context.go(HomeRoutes.home.fullPath);
    } else if (state is LoginFailureState) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(_failureText(state.reason))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocConsumer<LoginController, LoginState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final isLoading = state is LoginLoadingState;
        final validation = state is LoginValidationErrorState ? state : null;

        return SdKeyboardDismisserV5(
          child: SdSafeAreaScaffoldV5(
            backgroundColor: colors.pageDefault,
            contentBgColor: colors.pageDefault,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SdSpacingV5.s24,
                vertical: SdSpacingV5.s40,
              ),
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _LoginHeader(),
                    SdVerticalSpacingV5(value: SdSpacingV5.s32),
                    DemoAccountCard(onUse: _fillDemoAccount),
                    SdVerticalSpacingV5(value: SdSpacingV5.s24),
                    LoginTextField(
                      controller: _emailController,
                      label: context.loc.login_email_label,
                      hint: context.loc.login_email_hint,
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      errorText: _fieldErrorText(validation?.emailError),
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s16),
                    LoginTextField(
                      controller: _passwordController,
                      label: context.loc.login_password_label,
                      hint: context.loc.login_password_hint,
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      errorText: _fieldErrorText(validation?.passwordError),
                      onSubmitted: (_) => _submit(),
                      suffix: SdIconButtonV5(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: SdIconV5(
                          iconData: _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          iconSize: SdSpacingV5.s20,
                          color: colors.iconSecondary,
                        ),
                      ),
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s32),
                    SdButtonV5(
                      title: isLoading
                          ? context.loc.login_signing_in
                          : context.loc.login_button,
                      widthType: SdButtonWidthV5.full,
                      buttonSize: SdButtonSizeV5.large,
                      borderRadiusValue: SdSpacingV5.s12,
                      isDisabled: isLoading,
                      colorConfig: Helper.getSdButtonColorConfig(context),
                      onTap: _submit,
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s24),
                    _RegisterPrompt(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Column(
      children: [
        Container(
          width: _kLogoSize,
          height: _kLogoSize,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(SdSpacingV5.s16),
          ),
          child: Center(
            child: SdIconV5(
              iconData: Icons.shopping_bag_outlined,
              iconSize: SdSpacingV5.s32,
              color: colors.onPrimary,
            ),
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s16),
        Text(
          context.loc.app_name,
          style: SdTextStyleV5.heading24()
              .wColor(colors.textDefault)
              .wDisplay(),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s24),
        Text(
          context.loc.login_title,
          style: SdTextStyleV5.heading24().copyWith(color: colors.textDefault),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s8),
        Text(
          context.loc.login_subtitle,
          textAlign: TextAlign.center,
          style: SdTextStyleV5.body14().copyWith(color: colors.textSubTitle),
        ),
      ],
    );
  }
}

class _RegisterPrompt extends StatelessWidget {
  const _RegisterPrompt();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.loc.login_no_account,
          style: SdTextStyleV5.body14().copyWith(color: colors.textSubTitle),
        ),
        TextButton(
          onPressed: () => context.push(RegisterRoutes.register.fullPath),
          child: Text(
            context.loc.login_register,
            style: SdTextStyleV5.body14().wSemiBold().copyWith(
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
