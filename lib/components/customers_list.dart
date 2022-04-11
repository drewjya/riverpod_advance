
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/components/custom_card.dart';
import 'package:riverpod_advance/model/customers_model.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_state.dart';

class BuilderCustomersList extends ConsumerWidget {
  const BuilderCustomersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(customerStateNotifier(ref.read(authProvider).user!));
    List<CustomersRetrieve> customers = [];
    if (state is CustomersLoaded) {
      customers = state.customers;
      return ListView.builder(
        itemBuilder: (context, index) {
          return CustomCard(
            index: index,
            maxItem: customers.length,
            customer: customers[index],
          );
        },
        itemCount: customers.length,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}