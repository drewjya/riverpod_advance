
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/screen/welcome_screen.dart';

class BottomNavbarConsumer extends StatelessWidget {
  const BottomNavbarConsumer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.blue.shade900,
      notchMargin: 1.0,
      child: SizedBox(
        height: 50,
        child: Consumer(
          builder: (context, ref, _) {
            final listItem = [
              Icon(
                Icons.menu,
                color: ref.watch(navbarProvider) == 0
                    ? Colors.white
                    : Colors.lightBlue,
              ),
              Icon(
                Icons.person,
                color: ref.watch(navbarProvider) == 1
                    ? Colors.white
                    : Colors.lightBlue,
              ),
            ];
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: listItem
                  .map(
                    (e) => IconButton(
                        onPressed: () => ref.read(navbarProvider.state).state =
                            listItem.indexOf(e),
                        icon: e),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
