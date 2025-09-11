import "dart:io";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/user/presentation/viewmodels/edit_profile_viewmodel.dart";
import "package:mbelys/features/user/presentation/widgets/custom_change_button.dart";
import "package:mbelys/features/user/presentation/widgets/edit_profile_background_page.dart";
import "package:mbelys/features/user/presentation/widgets/edit_custom_button.dart";
import "package:mbelys/presentation/widgets/custom_avatar.dart";
import "package:mbelys/presentation/widgets/custom_pick_image.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:mbelys/presentation/widgets/custom_snackbar.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";
import "package:provider/provider.dart";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<EditProfileViewModel>(),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final textStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final vm = context.watch<EditProfileViewModel>();
    final user = vm.user;
    final state = vm.state;

    return EditProfileBackgroundPage(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.01),
              CustomAvatar(
                radius: 70,
                photoUrl: user?.photoUrl,
                localImageFile: vm.localPhoto,
              ),
              const SizedBox(height: 6,),
              CustomChangeButton(
                  onTap: () async {
                    final File? imageFile = await CustomPickImage.showImagePickerOptions(context);
                    if (imageFile != null) {
                      vm.setImage(imageFile);
                    }
                  }
              ),
              const SizedBox(height: 15,),
              Form(
                key: vm.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama",
                      style: textStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      hintText: user?.name,
                      textEditingController: vm.nameController,
                      validator: vm.validateName,
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Nomor Telepon",
                      style: textStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      hintText: user?.phone,
                      textEditingController: vm.phoneController,
                      validator: vm.validatePhone,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              EditCustomButton(
                textButton: "Password",
                onPressed: () => context.push(RouterPath.password),
              ),
              const SizedBox(height: 30,),
              CustomShortButton(
                  onTap: state == EditState.loading ? null : () async {
                    await vm.saveChanges();
                    if (!context.mounted) return;
                    if (vm.state == EditState.error) {
                      showErrorSnackBar(context, vm.error);
                    } else if (vm.state == EditState.success) {
                      context.go(RouterPath.profile);
                    }
                  },
                  buttonText: "Simpan",
                isLoading: state == EditState.loading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
