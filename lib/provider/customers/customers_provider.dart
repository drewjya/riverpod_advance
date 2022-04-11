import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/model/customers_model.dart';
import 'package:riverpod_advance/model/users_model.dart';
import 'package:riverpod_advance/provider/customers/customers_state.dart';
import 'package:riverpod_advance/service/db_helper.dart';

final customerStateNotifier =
    StateNotifierProvider.family<CustomersNotifier, CustomersState, UserModel>(
        (ref, user) => CustomersNotifier(user));

class CustomersNotifier extends StateNotifier<CustomersState> {
  CustomersNotifier(UserModel user) : super(CustomersInitial(user)) {
    _loadCustomers();
  }
  void _loadCustomers() async {
    state = CustomersLoading(state.user);
    final retrieve = await DbHelper.getCustomers();
    
    state = CustomersLoading(state.user);
    state = CustomersLoaded(
      state.user,
      customers: retrieve,
    );
  }

  void addCustomers(CustomerSubmit customer) async {
    await DbHelper.createCustomer(customer);
    _loadCustomers();
  }

  void removeCustomers(CustomersRetrieve customer) {
    if (state is CustomersLoaded) {
      final stateCurr = state as CustomersLoaded;
      final data = stateCurr.customers;
      state = CustomersLoading(state.user);
      data.removeWhere(
        (element) => element.customerId == customer.customerId,
      );
      state = CustomersDelete(state.user);
      state = CustomersLoaded(state.user, customers: data);
    }
  }
}
