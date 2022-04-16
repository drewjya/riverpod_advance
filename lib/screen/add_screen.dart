import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/components/custom_text_field.dart';
import 'package:riverpod_advance/components/date_picker.dart';
import 'package:riverpod_advance/components/image_picker.dart';
import 'package:riverpod_advance/model/customers_model.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_provider.dart';
import 'package:riverpod_advance/service/validator.dart';
import '../function/size_extention.dart';

final addStateProvider = StateProvider<int>((ref) {
  return 0;
});

class AddCustomerScreen extends HookConsumerWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final noHpController = useTextEditingController();
    final dobController = useTextEditingController();
    final merkController = useTextEditingController();
    final modelController = useTextEditingController();
    final imageController = useTextEditingController();
    final part3 = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        toolbarHeight: 55,
        title: const TitleAppBar(),
        leading: IconButton(
            onPressed: () {
              if (ref.read(addStateProvider) != 0) {
                ref.read(addStateProvider.state).state--;
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: context.getWidth(),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Column(
                children: [
                  ConsumerCustomText(
                    controller: nameController,
                    label: 'Name',
                    status: 0,
                    validator: Validator(minLenth: 5).checkEmpty,
                  ),
                  ConsumerCustomText(
                    controller: noHpController,
                    label: 'Phone Number',
                    status: 0,
                    validator: Validator().checkNumberPhone,
                  ),
                  ConsumerCustomText(
                    controller: dobController,
                    label: 'Date of Birth',
                    status: 0,
                    validator: Validator().checkEmpty,
                  ),
                ],
              ),
              Column(
                children: [
                  ConsumerCustomText(
                    controller: merkController,
                    label: 'Vehicle Brand',
                    status: 1,
                    validator: Validator().checkEmpty,
                  ),
                ],
              ),
              ConsumerCustomText(
                controller: modelController,
                label: 'Vehicle Model',
                status: 1,
                validator: Validator().checkEmpty,
              ),
              Consumer(
                builder: (context, refe, child) {
                  if (refe.watch(addStateProvider) == 2) {
                    return ImagePicker(
                        keyForm: part3, controller: imageController);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (ref.read(addStateProvider) == 0 &&
                        Validator().checkEmpty(nameController.text) == null &&
                        Validator().checkNumberPhone(noHpController.text) ==
                            null &&
                        Validator().checkEmpty(dobController.text) == null) {
                      ref.read(addStateProvider.state).state++;
                    } else if (ref.read(addStateProvider) == 1 &&
                        Validator().checkEmpty(merkController.text) == null &&
                        Validator().checkEmpty(merkController.text) == null) {
                      ref.read(addStateProvider.state).state++;
                    } else if (ref.read(addStateProvider) == 2 &&
                        imageController.text.isNotEmpty) {
                      final customer = CustomerSubmit(
                          customerName: nameController.text,
                          customersNum: noHpController.text,
                          dob: dobController.text,
                          model: modelController.text,
                          merk: merkController.text,
                          picture: imageController.text,
                          createdBy: ref.read(authProvider).user!.id!);
                      ref
                          .read(customerStateNotifier(
                                  ref.read(authProvider).user!)
                              .notifier)
                          .addCustomers(customer);

                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Next")),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsumerCustomText extends ConsumerWidget {
  const ConsumerCustomText({
    Key? key,
    required this.validator,
    required this.label,
    required this.controller,
    required this.status,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int status;
  final String label;

  @override
  Widget build(BuildContext context, ref) {
    return (ref.watch(addStateProvider) >= status)
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: (label == "Date of Birth")
                ? DatePicker(
                    controller: controller,
                    validator: validator!,
                    enabled: ref.watch(addStateProvider) == status)
                : CustomTextFormField(
                    password: false,
                    width: 340,
                    enabled: ref.watch(addStateProvider) == status,
                    validator: validator,
                    label: label,
                    border: true,
                    controller: controller,
                  ),
          )
        : const SizedBox();
  }
}

class TitleAppBar extends ConsumerWidget {
  const TitleAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _title = ["Data Konsumen", "Data Kendaraan", "Data Ktp"];
    return Text(_title[ref.watch(addStateProvider)]);
  }
}
