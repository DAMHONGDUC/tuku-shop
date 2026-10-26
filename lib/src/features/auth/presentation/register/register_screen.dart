import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/components/login_text_field.dart';

import 'register_controller.dart';

/// Create an account; it is signed in straight away.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterController>(),
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<RegisterController>().submit(
      RegisterParams(
        fullName: _name.text,
        email: _email.text,
        password: _password.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<RegisterController, RegisterState>(
      listener: (context, state) {
        if (state.user != null) context.go(HomeRoutes.home.fullPath);
        if (state.emailTaken || state.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.emailTaken
                    ? loc.register_email_taken
                    : loc.login_error_unknown,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        String? error(RegisterField f, String message) =>
            state.errors.contains(f) ? message : null;

        return SdKeyboardDismisserV5(
          child: Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: AppTopBar(showCart: false),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s24,
                  SdSpacingV5.s8,
                  SdSpacingV5.s24,
                  SdSpacingV5.s24,
                ),
                children: [
                  Text(
                    loc.register_title,
                    style: SdTextStyleV5.heading24().wColor(colors.textDefault),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s8),
                  Text(
                    loc.register_subtitle,
                    style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s32),
                  LoginTextField(
                    controller: _name,
                    label: loc.address_full_name,
                    hint: 'Linh Nguyen',
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    errorText: error(
                      RegisterField.fullName,
                      loc.address_field_invalid,
                    ),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  LoginTextField(
                    controller: _email,
                    label: loc.login_email_label,
                    hint: loc.login_email_hint,
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    errorText: error(
                      RegisterField.email,
                      loc.login_error_email_invalid,
                    ),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  LoginTextField(
                    controller: _password,
                    label: loc.login_password_label,
                    hint: loc.register_password_hint,
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    onSubmitted: (_) => _submit(),
                    errorText: error(
                      RegisterField.password,
                      loc.register_password_short,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: colors.iconSecondary,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s32),
                  AppButton(
                    label: loc.register_button,
                    isLoading: state.isSubmitting,
                    onTap: _submit,
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.register_have_account,
                        style: SdTextStyleV5.body14().wColor(
                          colors.textSubTitle,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          loc.login_button,
                          style: SdTextStyleV5.body14().wSemiBold().wColor(
                            colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
