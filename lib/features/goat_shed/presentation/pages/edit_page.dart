import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/device/presentation/viewmodels/provision_viewmodel.dart';
import 'package:mbelys/features/device/presentation/widgets/provision_card.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<EditViewModel>(param1: shedId)),
        ChangeNotifierProvider(create: (_) => sl<ProvisionViewModel>())
      ],
      child: const EditView(),
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

    final editViewModel = context.watch<EditViewModel>();
    final state = editViewModel.state;
    final shed = editViewModel.shed;
    final provisionViewModel = context.watch<ProvisionViewModel>();
    final provisionState = provisionViewModel.status;

    return CustomBackgroundPage(
        title: "Edit Kandang",
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Form(
                key: editViewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: editViewModel.nameController,
                      validator: editViewModel.validateName,
                      hintText: shed?.shedName,
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Gambar Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomAddImage(
                      localPhoto: editViewModel.localPhoto,
                      onPicked: editViewModel.setImage,
                      pickImage: () => CustomPickImage.showImagePickerOptions(context),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Lokasi Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: editViewModel.locationController,
                      validator: editViewModel.validateLocation,
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
                      textEditingController: editViewModel.totalController,
                      validator: editViewModel.validateTotal,
                      isNumber: true,
                      hintText: shed?.totalGoats.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              ProvisionCard(),
              const SizedBox(height: 25,),
              CustomShortButton(
                onTap: state == EditState.loading ? null : () async {
                  editViewModel.connectWifi = provisionState == ProvisionStatus.wifiConnected ? true : false;
                  editViewModel.deviceId = provisionViewModel.currentDeviceId;
                  await editViewModel.saveChanges();
                  if (!context.mounted) return;
                  if (editViewModel.state == EditState.error){
                    showErrorSnackBar(context, editViewModel.errorMessage);
                  } else if (editViewModel.state == EditState.success) {
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
              ),
              const SizedBox(height: 40,),
              CustomShortButton(
                buttonText: "Hapus",
                buttonColor: AppColors.color5,
                isLoading: state == EditState.loading,
                onTap: () async {
                  customDialog(
                    context,
                    "Hapus Kandang",
                    "Apakah anda yakin ingin menghapus kandang ini?",
                    "Benar",
                    () async {
                      context.pop();
                      final result = await context.read<EditViewModel>().deleteShed();
                      if (!context.mounted) return;
                      result.fold(
                        (failure) => showErrorSnackBar(context, failure.message),
                        (_) {
                          context.pop();
                          context.pop();
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 50,)
            ],
          ),
        )
    );
  }
}

