import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/device/presentation/viewmodels/provision_viewmodel.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/custom_add_image.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/custom_pick_image.dart";
import "package:mbelys/features/device/presentation/widgets/provision_card.dart";
import "package:mbelys/features/goat_shed/presentation/viewmodel/add_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:mbelys/presentation/widgets/custom_dialog.dart";
import "package:mbelys/presentation/widgets/custom_snackbar.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";
import "package:provider/provider.dart";

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<AddViewModel>()),
          ChangeNotifierProvider(create: (_) => sl<ProvisionViewModel>())
        ],
      child: const AddView(),
    );
  }
}

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final addViewModel = context.watch<AddViewModel>();
    final provisionViewModel = context.read<ProvisionViewModel>();
    final state = addViewModel.state;

    return CustomBackgroundPage(
        title: "Detail Kandang",
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Form(
                key: addViewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: addViewModel.nameController,
                      validator: addViewModel.validateName,
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Gambar Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomAddImage(
                      localPhoto: addViewModel.localPhoto,
                      onPicked: addViewModel.setImage,
                      pickImage: () => CustomPickImage.showImagePickerOptions(context),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Lokasi Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: addViewModel.locationController,
                      validator: addViewModel.validateLocation,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Jumlah Kambing",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: addViewModel.totalController,
                      validator: addViewModel.validateTotal,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              ProvisionCard(

              ),
              const SizedBox(height: 40,),
              CustomShortButton(
                  onTap: state == AddState.loading ? null : () async {
                    try {
                      if (!provisionViewModel.isConnected) {
                        showErrorSnackBar(context, "Hubungkan Perangkat Mbelys-IoT terlebih dahulu");
                        return;
                      }
                      String devId = provisionViewModel.currentDeviceId ?? "";
                      if (devId.isEmpty) {
                        devId = await provisionViewModel.assignDeviceIdOnSave();
                      }
                      addViewModel.deviceId = devId;
                      await addViewModel.addGoatShed();
                      if (!context.mounted) return;
                      if (addViewModel.state == AddState.error){
                        showErrorSnackBar(context, addViewModel.errorMessage);
                      } else if (addViewModel.state == AddState.success) {
                        customDialog(
                            context,
                            "Berhasil ditambahkan",
                            "Kandang baru Anda kini terintegrasi dengan perangkat IoT. "
                                "Pemantauan suara akan segera dimulai.",
                            "Baik",
                                () => context.goNamed(RouterName.home)
                        );
                      }
                    } catch (e) {
                      showErrorSnackBar(context, e.toString());
                    }
                  },
                  buttonText: "Simpan",
                  isLoading: state == AddState.loading,
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
    );
  }
}
