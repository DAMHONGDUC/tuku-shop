import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/session_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import 'edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<EditProfileController>(
    create: (BuildContext _) => getIt<EditProfileController>(),
    child: const _EditProfileView(),
  );
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    final UserEntity? user = context.read<SessionController>().state.user;
    _name = TextEditingController(text: user?.fullName);
    _email = TextEditingController(text: user?.email);
    _phone = TextEditingController(text: user?.phone);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<EditProfileController>().submit(
      fullName: _name.text,
      email: _email.text,
      phone: _phone.text,
    );
  }

  String? _fieldError(EditProfileFieldError? error) => switch (error) {
    null => null,
    EditProfileFieldError.required => context.loc.validation_required,
    EditProfileFieldError.invalidEmail => context.loc.validation_email,
    EditProfileFieldError.invalidPhone => context.loc.validation_phone,
  };

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<EditProfileController, EditProfileState>(
        listenWhen: (EditProfileState a, EditProfileState b) =>
            a.saved != b.saved || (b.failure != null && a.failure != b.failure),
        listener: (BuildContext context, EditProfileState state) {
          if (state.saved) {
            SdSnackBarUtilsV5.success(context, context.loc.edit_profile_saved);
            context.pop();
          } else if (state.failure != null) {
            SdSnackBarUtilsV5.error(context, context.loc.error_message);
          }
        },
        builder: (BuildContext context, EditProfileState state) => SdScaffoldV5(
          appBar: SdAppBarV5(title: context.loc.edit_profile_title),
          body: SdKeyboardDismissV5(
            child: ListView(
              padding: SdContentPaddingV5.gutter.copyWith(
                top: SdSpacingConstant.h8,
                bottom: SdContentPaddingV5.detailBottom(context),
              ),
              children: <Widget>[
                SdFadeInV5(
                  child: SdTextFieldV5(
                    label: context.loc.field_full_name,
                    hint: context.loc.field_full_name_hint,
                    controller: _name,
                    prefixIcon: Symbols.person_rounded,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    autofillHints: const <String>[AutofillHints.name],
                    errorText: _fieldError(state.nameError),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 1,
                  child: SdTextFieldV5(
                    label: context.loc.field_email,
                    hint: context.loc.field_email_hint,
                    controller: _email,
                    prefixIcon: Symbols.mail_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const <String>[AutofillHints.email],
                    errorText: _fieldError(state.emailError),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdFadeInV5(
                  index: 2,
                  child: SdTextFieldV5(
                    label: context.loc.field_phone,
                    controller: _phone,
                    prefixIcon: Symbols.call_rounded,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    autofillHints: const <String>[
                      AutofillHints.telephoneNumber,
                    ],
                    errorText: _fieldError(state.phoneError),
                    onSubmitted: (String _) => _submit(),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h24),
                SdFadeInV5(
                  index: 3,
                  child: SdButtonV5(
                    variant: SdButtonVariantV5.primary,
                    size: SdButtonSizeV5.large,
                    label: context.loc.edit_profile_save,
                    expand: true,
                    busy: state.submitting,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
