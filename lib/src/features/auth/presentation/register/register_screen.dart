import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import '../widgets/auth_messages.dart';
import '../widgets/password_field.dart';
import '../widgets/password_strength_meter.dart';
import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<RegisterController>(
    create: (BuildContext _) => getIt<RegisterController>(),
    child: const _RegisterView(),
  );
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();

    final RegisterController controller = context.read<RegisterController>();

    if (!controller.state.termsAccepted) {
      SdSnackBarUtilsV5.info(context, context.loc.register_accept_terms);
    }

    controller.submit(
      fullName: _name.text,
      email: _email.text,
      password: _password.text,
      confirm: _confirm.text,
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<RegisterController, RegisterState>(
        listenWhen: (RegisterState a, RegisterState b) =>
            a.done != b.done || (b.failure != null && a.failure != b.failure),
        listener: (BuildContext context, RegisterState state) {
          if (state.done) {
            SdSnackBarUtilsV5.success(context, context.loc.register_welcome);
            context.go(AppRoutes.home.path);
          } else if (state.failure != null) {
            SdSnackBarUtilsV5.error(context, context.failureMessage(state.failure!));
          }
        },
        builder: (BuildContext context, RegisterState state) => SdScaffoldV5(
          appBar: const SdAppBarV5(),
          body: SdKeyboardDismissV5(
            child: ListView(
              padding: SdContentPaddingV5.gutter.copyWith(
                bottom: SdContentPaddingV5.detailBottom(context),
              ),
              children: <Widget>[
                SdFadeInV5(
                  child: Text(
                    context.loc.register_title,
                    style: context.textTheme5.displaySmall,
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h6),
                SdFadeInV5(
                  index: 1,
                  child: Text(
                    context.loc.register_subtitle,
                    style: context.textTheme5.bodyMedium!.muted5(context),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h24),
                SdFadeInV5(
                  index: 2,
                  child: SdTextFieldV5(
                    label: context.loc.field_full_name,
                    hint: context.loc.field_full_name_hint,
                    controller: _name,
                    prefixIcon: Symbols.person_rounded,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    errorText: context.fieldError(state.nameError),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 3,
                  child: SdTextFieldV5(
                    label: context.loc.field_email,
                    hint: context.loc.field_email_hint,
                    controller: _email,
                    prefixIcon: Symbols.mail_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    errorText: context.fieldError(state.emailError),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 4,
                  child: PasswordField(
                    label: context.loc.field_password,
                    controller: _password,
                    textInputAction: TextInputAction.next,
                    errorText: context.fieldError(state.passwordError),
                    onChanged: (String _) => setState(() {}),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h8),
                PasswordStrengthMeter(
                  strength: RegisterController.passwordStrength(_password.text),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 5,
                  child: PasswordField(
                    label: context.loc.field_confirm_password,
                    controller: _confirm,
                    errorText: context.fieldError(state.confirmError),
                    onSubmitted: (String _) => _submit(),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 6,
                  child: SdCheckboxV5(
                    value: state.termsAccepted,
                    label: context.loc.register_terms,
                    onChanged: context.read<RegisterController>().acceptTerms,
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h24),
                SdFadeInV5(
                  index: 7,
                  child: SdButtonV5(
                    variant: SdButtonVariantV5.primary,
                    size: SdButtonSizeV5.large,
                    label: context.loc.register_submit,
                    expand: true,
                    busy: state.submitting,
                    onPressed: _submit,
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      context.loc.register_have_account,
                      style: context.textTheme5.bodyMedium!.muted5(context),
                    ),
                    SdButtonV5(
                      variant: SdButtonVariantV5.text,
                      size: SdButtonSizeV5.small,
                      label: context.loc.login_submit,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
