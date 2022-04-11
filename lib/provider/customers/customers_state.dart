import 'package:equatable/equatable.dart';

import 'package:riverpod_advance/model/customers_model.dart';
import 'package:riverpod_advance/model/users_model.dart';

abstract class CustomersState extends Equatable {
  
  final UserModel user;
  const CustomersState( this.user);
}

class CustomersInitial extends CustomersState {
  const CustomersInitial( UserModel user) : super(user);
  @override
  List<Object> get props => [];
}

class CustomersLoaded extends CustomersState {
  final List<CustomersRetrieve> customers;
  const CustomersLoaded(
     UserModel user,{
    required this.customers,
  }) : super(user);
  @override
  List<Object?> get props => [customers];
}

class CustomersLoading extends CustomersState {
  const CustomersLoading( UserModel user) : super(user);

  @override
  List<Object?> get props => [];
}

class CustomersDelete extends CustomersState {
  const CustomersDelete( UserModel user) : super(user);

  @override
  List<Object?> get props => [];
}

class CustomersAdded extends CustomersState {
  const CustomersAdded( UserModel user) : super(user);

  @override
  List<Object?> get props => [];
}

class CustomersError extends CustomersState {
  final Object? error;
  const CustomersError(
     UserModel user, {
    this.error,
  })  : super(user);

  @override
  List<Object?> get props => throw UnimplementedError();
}
