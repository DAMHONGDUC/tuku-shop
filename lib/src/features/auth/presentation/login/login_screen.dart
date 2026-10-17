import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_messages.dart';
import '../widgets/password_field.dart';
import 'components/demo_account_card.dart';
import 'components/forgot_password_sheet.dart';
import 'components/social_sign_in_row.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<LoginController>(
    create: (BuildContext _) => getIt<LoginController>()..loadDemoAccount(),
    child: const _LoginView(),
  );
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _remember = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _fillDemo(LoginState state) {
    if (state.demo == null) return;

    _email.text = state.demo!.email;
    _password.text = state.demo!.password;
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginController>().submit(
      email: _email.text,
      password: _password.text,
    );
  }

  void _onState(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      context.go(AppRoutes.home.path);
      return;
    }
    if (state.failure != null) {
      SdSnackBarUtilsV5.error(context, context.failureMessage(state.failure!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double headerHeight = MediaQuery.sizeOf(context).height * 0.34;

    return BlocConsumer<LoginController, LoginState>(
      listenWhen: (LoginState a, LoginState b) =>
          a.status != b.status || (b.failure != null && a.failure != b.failure) ||
          a.demo != b.demo,
      listener: (BuildContext context, LoginState state) {
        if (state.demo != null && _email.text.isEmpty) _fillDemo(state);
        _onState(context, state);
      },
      builder: (BuildContext context, LoginState state) => SdScaffoldV5(
        body: SdKeyboardDismissV5(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: SdContentPaddingV5.detailBottom(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AuthHeader(image: AppAssets.bannerYoga, height: headerHeight),
                Padding(
                  padding: SdContentPaddingV5.gutter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SdFadeInV5(
                        child: Text(
                          context.loc.login_title,
                          style: context.textTheme5.displaySmall,
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h6),
                      SdFadeInV5(
                        index: 1,
                        child: Text(
                          context.loc.login_subtitle,
                          style: context.textTheme5.bodyMedium!.muted5(context),
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h20),
                      if (state.demo != null)
                        SdFadeInV5(
                          index: 2,
                          child: DemoAccountCard(
                            demo: state.demo!,
                            onFill: () => _fillDemo(state),
                          ),
                        ),
                      SizedBox(height: SdSpacingConstant.h20),
                      SdFadeInV5(
                        index: 3,
                        child: SdTextFieldV5(
                          label: context.loc.field_email,
                          hint: context.loc.field_email_hint,
                          controller: _email,
                          prefixIcon: Symbols.mail_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const <String>[AutofillHints.email],
                          errorText: context.fieldError(state.emailError),
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h16),
                      SdFadeInV5(
                        index: 4,
                        child: PasswordField(
                          label: context.loc.field_password,
                          controller: _password,
                          errorText: context.fieldError(state.passwordError),
                          onSubmitted: (String _) => _submit(),
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h12),
                      SdFadeInV5(
                        index: 5,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SdCheckboxV5(
                                value: _remember,
                                label: context.loc.login_remember,
                                onChanged: (bool v) => setState(() => _remember = v),
                              ),
                            ),
                            SdButtonV5(
                              variant: SdButtonVariantV5.text,
                              size: SdButtonSizeV5.small,
                              label: context.loc.login_forgot,
                              onPressed: () => showSdBottomSheetV5<void>(
                                context: context,
                                builder: (BuildContext _) => BlocProvider<LoginController>.value(
                                  value: context.read<LoginController>(),
                                  child: ForgotPasswordSheet(initialEmail: _email.text),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h20),
                      SdFadeInV5(
                        index: 6,
                        child: SdButtonV5(
                          variant: SdButtonVariantV5.primary,
                          size: SdButtonSizeV5.large,
                          label: context.loc.login_submit,
                          expand: true,
                          busy: state.status == LoginStatus.submitting,
                          onPressed: _submit,
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h24),
                      const SdFadeInV5(index: 7, child: SocialSignInRow()),
                      SizedBox(height: SdSpacingConstant.h24),
                      SdFadeInV5(
                        index: 8,
                        child: _SwitchPrompt(
                          prompt: context.loc.login_no_account,
                          action: context.loc.login_create_account,
                          onTap: () => context.push(AppRoutes.register.path),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchPrompt extends StatelessWidget {
  const _SwitchPrompt({
    required this.prompt,
    required this.action,
    required this.onTap,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(prompt, style: context.textTheme5.bodyMedium!.muted5(context)),
      SdButtonV5(
        variant: SdButtonVariantV5.text,
        size: SdButtonSizeV5.small,
        label: action,
        onPressed: onTap,
      ),
    ],
  );
}
