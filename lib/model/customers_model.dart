import 'package:equatable/equatable.dart';

abstract class CustomersModel extends Equatable {
  final String customerName;
  final String customersNum;
  final String dob;
  final String model;
  final String merk;
  final String picture;
  final int createdBy;
  const CustomersModel({
    required this.customerName,
    required this.customersNum,
    required this.dob,
    required this.model,
    required this.merk,
    required this.picture,
    required this.createdBy,
  });

  @override
  List<Object> get props {
    return [
      customerName,
      customersNum,
      dob,
      model,
      merk,
      picture,
      createdBy,
    ];
  }
}

class CustomerSubmit extends CustomersModel {
  const CustomerSubmit(
      {required String customerName,
      required String customersNum,
      required String dob,
      required String model,
      required String merk,
      required String picture,
      required int createdBy})
      : super(
            customerName: customerName,
            customersNum: customersNum,
            dob: dob,
            model: model,
            merk: merk,
            picture: picture,
            createdBy: createdBy);
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customersNum': customersNum,
      'dob': dob,
      'model': model,
      'merk': merk,
      'picture': picture,
      'createdBy': createdBy,
    };
  }
}

class CustomersRetrieve extends CustomersModel {
  final int customerId;
  const CustomersRetrieve(
      {required String customerName,
      required this.customerId,
      required String customersNum,
      required String dob,
      required String model,
      required String merk,
      required String picture,
      required int createdBy})
      : super(
            customerName: customerName,
            customersNum: customersNum,
            dob: dob,
            model: model,
            merk: merk,
            picture: picture,
            createdBy: createdBy);
  @override
  List<Object> get props {
    return [
      customerName,
      customersNum,
      dob,
      model,
      merk,
      picture,
      createdBy,
    ];
  }

  factory CustomersRetrieve.fromMap(Map<String, dynamic> map) {
    return CustomersRetrieve(
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customersNum: map['customersNum'] ?? '',
      dob: map['dob'] ?? '',
      model: map['model'] ?? '',
      merk: map['merk'] ?? '',
      picture: map['picture'] ?? '',
      createdBy: map['createdBy']?.toInt() ?? 0,
    );
  }

  factory CustomersRetrieve.fromCustomersSubmit(
      CustomerSubmit customer, int id) {
    return CustomersRetrieve(
        customerName: customer.customerName,
        customerId: id,
        customersNum: customer.customersNum,
        dob: customer.dob,
        model: customer.model,
        merk: customer.merk,
        picture: customer.picture,
        createdBy: customer.createdBy);
  }
}


// "customerId"	INTEGER NOT NULL,
// "customerName"	TEXT NOT NULL DEFAULT "",
// "customersNum"	TEXT NOT NULL DEFAULT "",
// "dob"	TEXT NOT NULL DEFAULT "",
// "model"	TEXT NOT NULL DEFAULT "",
// "merk"	TEXT NOT NULL DEFAULT "",
// "picture"	TEXT,
// "createdBy"	INTEGER NOT NULL,
// PRIMARY KEY("customerId" AUTOINCREMENT),
// FOREIGN KEY("createdBy") REFERENCES "users"("id")
