import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/components/customers_list.dart';
import 'package:riverpod_advance/function/size_extention.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';

class ListCustomersScreen extends ConsumerWidget {
  const ListCustomersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.getHeight();
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(15),
            height: height * 0.085,
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            child: Consumer(builder: (context, refe, _) {
              return Text.rich(
                TextSpan(
                  text: "Welcome, ",
                  children: [
                    TextSpan(
                        text: refe.watch(authProvider).user!.username,
                        style: const TextStyle(color: Colors.red))
                  ],
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: height * (0.78),
            decoration: BoxDecoration(
                color: Colors.blueAccent.shade700,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: const BuilderCustomersList(),
          ),
        ),
      ],
    );
  }
}
