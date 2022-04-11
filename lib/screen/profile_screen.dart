import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/components/custom_card.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(customerStateNotifier(ref.read(authProvider).user!));
    if (state is CustomersLoaded) {
      final customers = state.customers
          .where(
              (element) => element.createdBy == ref.read(authProvider).user!.id)
          .toList();
      return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.blueAccent.shade700,
        child: ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) => CustomCard(
            maxItem: customers.length,
            customer: customers[index],
            index: index,
            delete: () => ref
                .read(customerStateNotifier(ref.read(authProvider).user!)
                    .notifier)
                .removeCustomers(customers[index]),
            edit: () {},
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
