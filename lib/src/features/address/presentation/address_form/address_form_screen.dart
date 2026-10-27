import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

import 'address_form_controller.dart';

/// Add or edit an address; pops `true` once saved.
class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({super.key, this.address});

  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressFormController>(),
      child: _Form(address: address),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({this.address});

  final AddressEntity? address;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late final _name = TextEditingController(text: widget.address?.fullName);
  late final _phone = TextEditingController(text: widget.address?.phone);
  late final _street = TextEditingController(text: widget.address?.street);
  late final _city = TextEditingController(text: widget.address?.city);
  late final _state = TextEditingController(text: widget.address?.state);
  late final _postal = TextEditingController(text: widget.address?.postalCode);
  late String _label = widget.address?.label ?? 'Home';
  late bool _isDefault = widget.address?.isDefault ?? false;

  @override
  void dispose() {
    for (final c in [_name, _phone, _street, _city, _state, _postal]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    FocusScope.of(context).unfocus();
    context.read<AddressFormController>().save(
      AddressEntity(
        id: widget.address?.id ?? '',
        label: _label,
        fullName: _name.text.trim(),
        phone: _phone.text.trim(),
        street: _street.text.trim(),
        city: _city.text.trim(),
        state: _state.text.trim(),
        postalCode: _postal.text.trim(),
        isDefault: _isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<AddressFormController, AddressFormState>(
      listener: (context, state) {
        if (state.saved != null) context.pop(true);
        if (state.saveFailed) {
          AppToast.of(
            context,
          ).show(loc.address_save_failed, type: AppToastType.error);
        }
      },
      builder: (context, state) {
        String? error(AddressField f) =>
            state.errors.contains(f) ? loc.address_field_invalid : null;

        Widget field(
          String label,
          TextEditingController controller,
          AddressField f, {
          TextInputType? keyboard,
        }) {
          return Padding(
            padding: EdgeInsets.only(bottom: SdSpacingV5.s12),
            child: TextField(
              controller: controller,
              keyboardType: keyboard,
              textInputAction: TextInputAction.next,
              style: SdTextStyleV5.body14().wColor(colors.textDefault),
              decoration: InputDecoration(
                labelText: label,
                errorText: error(f),
                filled: true,
                fillColor: colors.cardDefault,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  borderSide: BorderSide(color: colors.borderDefault),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  borderSide: BorderSide(color: colors.borderDefault),
                ),
              ),
            ),
          );
        }

        return SdKeyboardDismisserV5(
          child: Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: AppTopBar(
              title: widget.address == null
                  ? loc.address_add
                  : loc.address_edit,
              showCart: false,
            ),
            body: ListView(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              children: [
                Wrap(
                  spacing: SdSpacingV5.s8,
                  children: [
                    for (final label in ['Home', 'Office', 'Other'])
                      AppChip(
                        label: label,
                        selected: _label == label,
                        onTap: () => setState(() => _label = label),
                      ),
                  ],
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s16),
                field(loc.address_full_name, _name, AddressField.fullName),
                field(
                  loc.address_phone,
                  _phone,
                  AddressField.phone,
                  keyboard: TextInputType.phone,
                ),
                field(loc.address_street, _street, AddressField.street),
                field(loc.address_city, _city, AddressField.city),
                Row(
                  children: [
                    Expanded(
                      child: field(
                        loc.address_state,
                        _state,
                        AddressField.state,
                      ),
                    ),
                    SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                    Expanded(
                      child: field(
                        loc.address_postal_code,
                        _postal,
                        AddressField.postalCode,
                      ),
                    ),
                  ],
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _isDefault,
                  activeTrackColor: colors.primary,
                  onChanged: (v) => setState(() => _isDefault = v),
                  title: Text(
                    loc.address_make_default,
                    style: SdTextStyleV5.body14().wColor(colors.textDefault),
                  ),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s16),
                AppButton(
                  label: loc.address_save,
                  isLoading: state.isSaving,
                  onTap: _save,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
