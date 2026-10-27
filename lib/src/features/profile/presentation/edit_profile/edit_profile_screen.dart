import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import 'edit_profile_controller.dart';

/// Name and phone; pops with the updated user.
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileController>()..load(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<EditProfileController, EditProfileState>(
      listener: (context, state) {
        if (state.saved != null) context.pop(state.saved);
        if (state.saveFailed) {
          AppToast.of(
            context,
          ).show(loc.address_save_failed, type: AppToastType.error);
        }
      },
      builder: (context, state) => SdKeyboardDismisserV5(
        child: Scaffold(
          backgroundColor: colors.pageDefault,
          appBar: AppTopBar(title: loc.profile_edit, showCart: false),
          body: switch (state.status) {
            EditProfileStatus.loading => ListView(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              children: [
                for (var i = 0; i < 3; i++) ...[
                  const SkeletonBox(
                    height: SdSpacingV5.s56,
                    radius: SdSpacingV5.s12,
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s12),
                ],
              ],
            ),
            EditProfileStatus.error => Padding(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              child: SectionError(
                onRetry: context.read<EditProfileController>().load,
              ),
            ),
            EditProfileStatus.loaded => _Form(
              key: ValueKey(state.user!.id),
              user: state.user!,
              state: state,
            ),
          },
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key, required this.user, required this.state});

  final UserEntity user;
  final EditProfileState state;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late final _name = TextEditingController(text: widget.user.fullName);
  late final _phone = TextEditingController(text: widget.user.phone);
  late final _email = TextEditingController(text: widget.user.email);

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    InputDecoration decoration(String label, String? error) => InputDecoration(
      labelText: label,
      errorText: error,
      filled: true,
      fillColor: colors.cardDefault,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      ),
    );

    final state = widget.state;

    return ListView(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      children: [
        TextField(
          controller: _name,
          style: SdTextStyleV5.body14().wColor(colors.textDefault),
          decoration: decoration(
            loc.address_full_name,
            state.invalidField == 'full_name'
                ? loc.address_field_invalid
                : null,
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        TextField(
          controller: _phone,
          keyboardType: TextInputType.phone,
          style: SdTextStyleV5.body14().wColor(colors.textDefault),
          decoration: decoration(
            loc.address_phone,
            state.invalidField == 'phone' ? loc.address_field_invalid : null,
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        TextField(
          enabled: false,
          controller: _email,
          style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
          decoration: decoration(loc.login_email_label, null),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s24),
        AppButton(
          label: loc.profile_save,
          isLoading: state.isSaving,
          onTap: () {
            FocusScope.of(context).unfocus();
            context.read<EditProfileController>().save(
              fullName: _name.text,
              phone: _phone.text,
            );
          },
        ),
      ],
    );
  }
}
