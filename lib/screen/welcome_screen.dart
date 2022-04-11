import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/components/bottom_navbar.dart';
import 'package:riverpod_advance/function/size_extention.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/authentication/auth_state.dart';
import 'package:riverpod_advance/provider/customers/customers_provider.dart';
import 'package:riverpod_advance/provider/customers/customers_state.dart';
import 'package:riverpod_advance/screen/add_screen.dart';
import 'package:riverpod_advance/screen/landing_screen.dart';
import 'package:riverpod_advance/screen/list_customers_screen.dart';
import 'package:riverpod_advance/screen/profile_screen.dart';

final navbarProvider = StateProvider<int>((ref) => 0);

class WelcomeScreen extends HookConsumerWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final title = ["List of Customers", "Profile"];
  final body = [
    const ListCustomersScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context, ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthLogout) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 570), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              // contentPadding: const EdgeInsets.all(0),
              title: const Text(
                "Notification",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Row(
                children: const [
                  Spacer(flex: 2),
                  Icon(
                    Icons.delete,
                    size: 13,
                  ),
                  Spacer(),
                  Text(
                    "Successfully Deleted Data",
                    style: TextStyle(fontSize: 13),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            );
          },
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) => const LandingScreen()));
      }
    });
    final state = ref.watch(authProvider);
    if (state is AuthSuccess) {
      ref.listen<CustomersState>(
        customerStateNotifier(ref.read(authProvider).user!),
        (previous, next) {
          if (next is CustomersDelete) {
            showDialog(
              context: context,
              builder: (context) {
                Future.delayed(const Duration(milliseconds: 570), () {
                  Navigator.of(context).pop(true);
                });
                return AlertDialog(
                  // contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    "Notification",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: Row(
                    children: const [
                      Spacer(flex: 2),
                      Icon(
                        Icons.delete,
                        size: 13,
                      ),
                      Spacer(),
                      Text(
                        "Successfully Deleted Data",
                        style: TextStyle(fontSize: 13),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                );
              },
            );
          }
        },
        onError: (error, stackTrace) {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(milliseconds: 570), () {
                Navigator.of(context).pop(true);
              });
              return const AlertDialog();
            },
          );
        },
      );
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
          toolbarHeight: context.getHeight() * 0.085,
          title: Text(
            title[ref.watch(navbarProvider)],
          ),
          leading: IconButton(
              onPressed: () => ref
                  .read(authProvider.notifier)
                  .onLogout(ref.read(authProvider).user!),
              icon: const Icon(Icons.logout_outlined)),
        ),
        backgroundColor: Colors.white,
        body: body[ref.read(navbarProvider)],
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ref.read(addStateProvider.state).state = 0;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCustomerScreen(),
                ));
          },
          backgroundColor: Colors.blue.shade800,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavbarConsumer(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
