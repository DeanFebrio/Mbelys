import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/presentation/Widgets/custom_add_image.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/edit_viewmodel.dart';
import 'package:mbelys/presentation/widgets/custom_background_page.dart';
import 'package:mbelys/presentation/widgets/custom_dialog.dart';
import 'package:mbelys/features/goat_shed/presentation/Widgets/custom_pick_image.dart';
import 'package:mbelys/presentation/widgets/custom_short_button.dart';
import 'package:mbelys/presentation/widgets/custom_snackbar.dart';
import 'package:mbelys/presentation/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  final String shedId;
  const EditPage({
    super.key,
    required this.shedId
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<EditViewModel>(param1: shedId),
        child: const EditView()
    );
  }
}

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final vm = context.watch<EditViewModel>();
    final state = vm.state;
    final shed = vm.shed;

    return CustomBackgroundPage(
        title: "Edit Kandang",
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Form(
                key: vm.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: vm.nameController,
                      validator: vm.validateName,
                      hintText: shed?.shedName,
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Gambar Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomAddImage(
                      localPhoto: vm.localPhoto,
                      onPicked: vm.setImage,
                      pickImage: () => CustomPickImage.showImagePickerOptions(context),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Lokasi Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: vm.locationController,
                      validator: vm.validateLocation,
                      hintText: shed?.shedLocation,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Jumlah Kambing",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: vm.totalController,
                      validator: vm.validateTotal,
                      isNumber: true,
                      hintText: shed?.totalGoats.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              CustomShortButton(
                onTap: state == EditState.loading ? null : () async {
                  await vm.saveChanges();
                  if (!context.mounted) return;
                  if (vm.state == EditState.error){
                    showErrorSnackBar(context, vm.errorMessage);
                  } else if (vm.state == EditState.success) {
                    customDialog(
                        context,
                        "Berhasil diubah",
                        "Perubahan pada kandang berhasil disimpan",
                        "Baik",
                        () {
                          context.pop();
                          context.pop();
                        }
                    );
                  }
                },
                buttonText: "Simpan",
                isLoading: state == EditState.loading,
              )
            ],
          ),
        )
    );
  }
}

