import 'package:app_core/globals.dart';
import 'package:app_core/utils/ui_utils.dart';
import 'package:app_core/utils/utils.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:console_mixin/console_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:liso/core/persistence/persistence.dart';
import 'package:liso/core/utils/utils.dart';
import 'package:liso/features/app/routes.dart';
import 'package:liso/features/seed/seed_field.widget.dart';

import '../../core/utils/globals.dart';
import '../items/items.service.dart';
import '../menu/menu.item.dart';

class SeedScreenController extends GetxController with ConsoleMixin {
  // VARIABLES'

  List<ContextMenuItem> get menuItems => [
        if (!isDisplayMode) ...[
          ContextMenuItem(
            title: 'Generate',
            leading: Icon(Iconsax.chart_outline, size: popupIconSize),
            onSelected: _generate,
          ),
          ContextMenuItem(
            title: 'Custom',
            leading: Icon(Iconsax.key_outline, size: popupIconSize),
            onSelected: custom,
          ),
        ],
        ContextMenuItem(
          title: 'QR Code',
          leading: Icon(Iconsax.barcode_outline, size: popupIconSize),
          onSelected: _showQR,
        ),
        ContextMenuItem(
          title: 'Copy',
          leading: Icon(Iconsax.copy_outline, size: popupIconSize),
          onSelected: () => Utils.copyToClipboard(seed.value),
        ),
      ];

  // PROPERTIES
  final seed = ''.obs;
  final chkBackedUpSeed = false.obs;
  final chkWrittenSeed = false.obs;
  final passphraseIndexedStack = 0.obs;
  final isDisplayMode = Get.parameters['mode'] == 'display';

  // GETTERS
  bool get canProceed => chkBackedUpSeed.value && chkWrittenSeed.value;

  // INIT
  @override
  void onInit() {
    seed.value = bip39.generateMnemonic();
    super.onInit();
  }

  @override
  void onReady() async {
    if (isDisplayMode) {
      final result = await ItemsService.to.obtainFieldValue(
        itemId: 'seed',
        fieldId: 'seed',
      );

      if (result.isLeft) {
        return UIUtils.showSimpleDialog(
          'Seed Not Found',
          'Cannot find your saved seed',
        );
      }

      seed.value = result.right;
    }

    super.onReady();
  }

  // FUNCTIONS

  void continuePressed() async {
    AppPersistence.to.backedUpSeed.val = true;
    if (isDisplayMode) return Get.back();
    generatedSeed = seed.value;

    Utils.adaptiveRouteOpen(name: AppRoutes.createPassword);
  }

  void _showQR() {
    AppUtils.showQR(
      seed.value,
      title: 'Seed QR Code',
      subTitle: "Make sure you're in a safe location and free from prying eyes",
    );
  }

  void _generate() async {
    final seed_ = await Utils.adaptiveRouteOpen(
      name: AppRoutes.seedGenerator,
      parameters: {'return': 'true'},
    );

    if (seed_ == null) return;
    seed.value = seed_;
  }

  void custom() {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    void use() {
      if (!formKey.currentState!.validate()) return;
      seed.value = controller.text;
      Get.back();
    }

    final dialogContent = Form(
      key: formKey,
      child: SeedField(
        fieldController: controller,
        onFieldSubmitted: (text) => use(),
        showGenerate: false,
      ),
    );

    Get.dialog(AlertDialog(
      title: const Text('Enter Your Seed'),
      content: isSmallScreen
          ? dialogContent
          : SizedBox(
              width: 450,
              child: dialogContent,
            ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: use,
          child: Text('use'.tr),
        ),
      ],
    ));
  }
}
