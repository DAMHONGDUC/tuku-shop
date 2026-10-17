import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/components/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

import 'components/profile_app_bar.dart';
import 'components/profile_skeleton.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProfileController>()..getData()),
      ],
      child: _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future _onRefresh(BuildContext context) async {
    context.read<ProfileController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.pageDefault,
      contentBgColor: context.colorTheme.pageDefault,
      appBar: ProfileAppBar(),
      child: BlocConsumer<ProfileController, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        buildWhen: (previous, current) {
          return current is ProfileLoadingState ||
              current is ProfileLoadedState ||
              current is ProfileErrorState;
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return ProfileSkeleton();
          } else if (state is ProfileErrorState) {
            return EmptyView(message: state.errorMsg);
          } else if (state is ProfileLoadedState) {
            return RefreshWrapper(
              onRefresh: () => _onRefresh(context),
              child: SdListViewV5(
                padding: EdgeInsets.all(SdSpacingV5.s16),
                items: state.listSettingSection,
                separatorBuilder: (context, index) {
                  return SdVerticalSpacingV5();
                },
                itemBuilder: (_, index) {
                  return SettingSection(
                    settingSection: state.listSettingSection[index],
                  );
                },
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
