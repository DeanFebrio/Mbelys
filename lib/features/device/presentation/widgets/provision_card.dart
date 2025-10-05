import 'package:flutter/material.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/features/device/presentation/viewmodels/provision_viewmodel.dart';
import 'package:mbelys/presentation/widgets/custom_text_input.dart';
import 'package:mbelys/presentation/widgets/custom_short_button.dart';
import 'package:provider/provider.dart';

class ProvisionCard extends StatelessWidget {
  const ProvisionCard({ super.key });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProvisionViewModel>(
      builder: (context, vm, _) {
        final showForm = vm.status != ProvisionStatus.idle &&
            vm.status != ProvisionStatus.connectingDevice;

        return AnimatedCrossFade(
          crossFadeState: showForm
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
          firstCurve: Curves.easeOut,
          secondCurve: Curves.easeIn,
          sizeCurve: Curves.easeInOut,
          firstChild: BuildConnectButton(vm: vm),
          secondChild: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: BuildProvisionForm(vm: vm),
            ),
          ),
        );
      },
    );
  }
}

class BuildConnectButton extends StatelessWidget {
  final ProvisionViewModel vm;
  const BuildConnectButton({required this.vm, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShortButton(
      buttonText: vm.isBusy ? 'Menghubungkan…' : 'Scan & Hubungkan',
      buttonColor: AppColors.color10,
      icon: Icon(
        vm.isBusy ? Icons.bluetooth_searching : Icons.bluetooth,
        color: AppColors.color2,
        size: 20,
      ),
      onTap: vm.isBusy || vm.isConnected ? null : () => vm.connect(context),
    );
  }
}

class BuildProvisionForm extends StatefulWidget {
  final ProvisionViewModel vm;
  const BuildProvisionForm({required this.vm, super.key});

  @override
  State<BuildProvisionForm> createState() => BuildProvisionFormState();
}

class BuildProvisionFormState extends State<BuildProvisionForm> {
  bool _hiding = false;

  static const _fadeDur = Duration(milliseconds: 240);
  static const _sizeDur = Duration(milliseconds: 260);
  static const _curve = Curves.easeInOut;

  Future<void> handleDisconnect() async {
    if (_hiding) return;
    setState(() => _hiding = true);

    await Future.delayed(_fadeDur);

    await widget.vm.disconnect();

    if (mounted) setState(() => _hiding = false);
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.vm;

    final (title, icon, color) = switch (vm.status) {
      ProvisionStatus.idle =>
      ('Belum terhubung', Icons.info_outline, AppColors.color14),
      ProvisionStatus.connectingDevice =>
      ('Menghubungkan perangkat…', Icons.bluetooth_searching, AppColors.color11),
      ProvisionStatus.connectedDevice =>
      ('Perangkat terhubung', Icons.bluetooth_connected, AppColors.color4),
      ProvisionStatus.provisioning =>
      ('Menghubungkan ke Wi-Fi…', Icons.wifi_find, AppColors.color11),
      ProvisionStatus.wifiConnected =>
      ('Wi-Fi tersambung', Icons.wifi, AppColors.color4),
      ProvisionStatus.wifiFailed =>
      ('Wi-Fi gagal', Icons.error_outline, AppColors.color5),
    };

    final showInputs = !_hiding &&
        vm.status != ProvisionStatus.idle &&
        vm.status != ProvisionStatus.connectingDevice;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 25),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          if (vm.isBusy) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(
              minHeight: 3,
              color: AppColors.color11,
              backgroundColor: AppColors.color12,
            ),
          ],
          if (vm.currentDeviceId != null) ...[
          const SizedBox(height: 8),
          Text(
            "Device ID: ${vm.currentDeviceId}",
            style: const TextStyle(
            color: AppColors.color9,
            fontFamily: "Mulish",
            ),
          ),
          ],
          const SizedBox(height: 20),
          AnimatedSize(
            duration: _sizeDur,
            curve: _curve,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: _fadeDur,
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) {
                final offsetAnim = Tween<Offset>(
                  begin: const Offset(0, -0.06),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: _curve));
                return FadeTransition(
                  opacity: anim,
                  child: SlideTransition(position: offsetAnim, child: child),
                );
              },
              child: showInputs
                  ? Column(
                key: const ValueKey('form-visible'),
                children: [
                  Form(
                    child: Column(
                      children: [
                        CustomTextInput(
                          textEditingController: vm.ssidController,
                          isEnabled:
                          vm.isConnected && !vm.isBusy && !_hiding,
                          hintText: "Nama Wi-Fi",
                        ),
                        const SizedBox(height: 10),
                        CustomTextInput(
                          textEditingController: vm.passController,
                          isEnabled:
                          vm.isConnected && !vm.isBusy && !_hiding,
                          hintText: "Password Wi-Fi",
                          isPassword: true,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      CustomShortButton(
                        buttonText: "Hubungkan",
                        buttonColor: AppColors.color10,
                        icon: const Icon(
                          Icons.wifi,
                          color: AppColors.color2,
                          size: 20,
                        ),
                        onTap: vm.isConnected &&
                            !vm.isBusy &&
                            !_hiding
                            ? vm.sendProvision
                            : null,
                        isLoading:
                        vm.status == ProvisionStatus.provisioning,
                      ),
                      CustomShortButton(
                        buttonText: "Putuskan",
                        buttonColor: AppColors.color10,
                        icon: const Icon(
                          Icons.bluetooth_disabled,
                          color: AppColors.color2,
                          size: 20,
                        ),
                        onTap: vm.isBusy ? null : handleDisconnect,
                        isLoading: false,
                      ),
                    ],
                  ),
                ],
              )
                  : const SizedBox.shrink(key: ValueKey('form-hidden')),
            ),
          ),
        ],
      ),
    );
  }
}
