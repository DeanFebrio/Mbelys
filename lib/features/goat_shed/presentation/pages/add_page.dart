import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/add_image.dart";
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
    return ChangeNotifierProvider(
        create: (_) => sl<AddViewModel>(),
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

    final vm = context.watch<AddViewModel>();
    final state = vm.state;

    return CustomBackgroundPage(
        title: "Detail Kandang",
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
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Gambar Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    AddImage(),
                    const SizedBox(height: 15,),
                    Text(
                      "Lokasi Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(
                      textEditingController: vm.locationController,
                      validator: vm.validateLocation,
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              CustomShortButton(
                  onTap: state == AddState.loading ? null : () async {
                    await vm.addGoatShed();
                    if (!context.mounted) return;
                    if (vm.state == AddState.error){
                      showErrorSnackBar(context, vm.errorMessage);
                    } else if (vm.state == AddState.success) {
                      customDialog(
                          context,
                          "Berhasil ditambahkan",
                          "Kandang baru Anda kini terintegrasi dengan perangkat IoT. "
                              "Pemantauan suara akan segera dimulai.",
                          "Baik",
                          RouterPath.home
                      );
                    }
                  },
                  buttonText: "Simpan",
                  isLoading: state == AddState.loading,
              )
            ],
          ),
        )
    );
  }
}
