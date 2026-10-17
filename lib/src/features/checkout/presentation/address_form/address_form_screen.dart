import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import 'address_form_controller.dart';

/// Add or edit an address. Pops with the saved id so checkout can pick it.
class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({this.args, super.key});

  final AddressFormArgs? args;

  @override
  Widget build(BuildContext context) => BlocProvider<AddressFormController>(
    create: (BuildContext _) =>
        getIt<AddressFormController>()..load(args?.addressId),
    child: BlocConsumer<AddressFormController, AddressFormState>(
      listenWhen: (AddressFormState a, AddressFormState b) => a.savedId != b.savedId,
      listener: (BuildContext context, AddressFormState state) {
        SdSnackBarUtilsV5.success(context, context.loc.address_saved);
        context.pop(state.savedId);
      },
      buildWhen: (AddressFormState a, AddressFormState b) => a.ready != b.ready,
      builder: (BuildContext context, AddressFormState state) => SdScaffoldV5(
        appBar: SdAppBarV5(
          title: state.existing == null
              ? context.loc.address_new_title
              : context.loc.address_edit_title,
        ),
        body: state.ready
            ? _AddressForm(existing: state.existing)
            : const Center(child: SdLoadingV5()),
      ),
    ),
  );
}

class _AddressForm extends StatefulWidget {
  const _AddressForm({required this.existing});

  final AddressEntity? existing;

  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm> {
  late final TextEditingController _name = TextEditingController(text: widget.existing?.fullName);
  late final TextEditingController _phone = TextEditingController(text: widget.existing?.phone);
  late final TextEditingController _street = TextEditingController(text: widget.existing?.street);
  late final TextEditingController _city = TextEditingController(text: widget.existing?.city);
  late final TextEditingController _postal = TextEditingController(text: widget.existing?.postalCode);
  late final TextEditingController _country = TextEditingController(
    text: widget.existing?.country ?? 'United States',
  );
  late String _label = widget.existing?.label ?? 'Home';
  late bool _default = widget.existing?.isDefault ?? false;

  static const List<String> _labels = <String>['Home', 'Office', 'Other'];

  @override
  void dispose() {
    for (final TextEditingController c in <TextEditingController>[
      _name,
      _phone,
      _street,
      _city,
      _postal,
      _country,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AddressFormController>().save(
      AddressEntity(
        id: widget.existing?.id ?? '',
        label: _label,
        fullName: _name.text.trim(),
        phone: _phone.text.trim(),
        street: _street.text.trim(),
        city: _city.text.trim(),
        postalCode: _postal.text.trim(),
        country: _country.text.trim(),
        isDefault: _default,
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AddressFormController, AddressFormState>(
        builder: (BuildContext context, AddressFormState state) {
          String? err(String key) =>
              state.missing.contains(key) ? context.loc.validation_required : null;
          final double gap = SdSpacingConstant.h16;

          return SdKeyboardDismissV5(
            child: ListView(
              padding: SdContentPaddingV5.gutter.copyWith(
                top: SdSpacingConstant.h8,
                bottom: SdContentPaddingV5.detailBottom(context),
              ),
              children: <Widget>[
                Text(context.loc.address_label, style: context.textTheme5.labelLarge),
                SizedBox(height: SdSpacingConstant.h8),
                Row(
                  children: <Widget>[
                    for (final String l in _labels) ...<Widget>[
                      SdChipV5(
                        label: switch (l) {
                          'Home' => context.loc.address_label_home,
                          'Office' => context.loc.address_label_office,
                          _ => context.loc.address_label_other,
                        },
                        icon: switch (l) {
                          'Home' => Symbols.home_rounded,
                          'Office' => Symbols.work_rounded,
                          _ => Symbols.location_on_rounded,
                        },
                        selected: _label == l,
                        onSelected: () => setState(() => _label = l),
                      ),
                      SizedBox(width: SdSpacingConstant.w8),
                    ],
                  ],
                ),
                SizedBox(height: gap),
                SdTextFieldV5(
                  label: context.loc.field_full_name,
                  controller: _name,
                  prefixIcon: Symbols.person_rounded,
                  textCapitalization: TextCapitalization.words,
                  errorText: err('name'),
                ),
                SizedBox(height: gap),
                SdTextFieldV5(
                  label: context.loc.field_phone,
                  controller: _phone,
                  prefixIcon: Symbols.call_rounded,
                  keyboardType: TextInputType.phone,
                  errorText: err('phone'),
                ),
                SizedBox(height: gap),
                SdTextFieldV5(
                  label: context.loc.field_street,
                  controller: _street,
                  prefixIcon: Symbols.signpost_rounded,
                  errorText: err('street'),
                ),
                SizedBox(height: gap),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SdTextFieldV5(
                        label: context.loc.field_city,
                        controller: _city,
                        errorText: err('city'),
                      ),
                    ),
                    SizedBox(width: SdSpacingConstant.w12),
                    Expanded(
                      flex: 2,
                      child: SdTextFieldV5(
                        label: context.loc.field_postal,
                        controller: _postal,
                        keyboardType: TextInputType.number,
                        errorText: err('postal'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap),
                SdTextFieldV5(
                  label: context.loc.field_country,
                  controller: _country,
                  prefixIcon: Symbols.public_rounded,
                ),
                SizedBox(height: SdSpacingConstant.h8),
                SdListTileV5(
                  title: context.loc.address_make_default,
                  trailing: SdSwitchV5(
                    value: _default,
                    semanticLabel: context.loc.address_make_default,
                    onChanged: (bool v) => setState(() => _default = v),
                  ),
                ),
                SizedBox(height: SdSpacingConstant.h16),
                SdButtonV5(
                  variant: SdButtonVariantV5.primary,
                  size: SdButtonSizeV5.large,
                  label: context.loc.address_save,
                  expand: true,
                  busy: state.saving,
                  onPressed: _save,
                ),
              ],
            ),
          );
        },
      );
}
