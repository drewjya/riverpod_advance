import 'package:flutter/material.dart';
import 'package:riverpod_advance/model/customers_model.dart';
import '../function/size_extention.dart';

class CustomCard extends StatelessWidget {
  final int index;
  final int maxItem;
  final CustomersRetrieve customer;

  final VoidCallback? delete;
  const CustomCard(
      {Key? key,
      required this.maxItem,
      this.delete,
      required this.customer,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = customer.customerName;
    final String nohp = customer.customersNum;
    final String merk = customer.merk;
    final String model = customer.model;
    return Container(
      margin: EdgeInsets.only(
        top: index != 0 ? 10 : 5,
        bottom: index != maxItem - 1 ? 10 : 5,
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: context.getHeight() * 0.18,
          width: context.getWidth(),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                // margin: const EdgeInsets.all(5),
                height: context.getHeight() * 0.18,
                width: context.getWidth() * 0.6358,
                child: (delete != null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: context.getHeight() * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                      text: name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " ($nohp)",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                ),
                                Text(
                                  "$merk $model",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const Text("Jl. M.T Haryono No 7")
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.getHeight() * 0.065,
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: delete,
                                    icon: const Icon(Icons.delete),
                                    label: const Text("Delete"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(
                        height: context.getHeight() * 0.13,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "($nohp)",
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              merk,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              model,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              "Jl. M.T Haryono No 7",
                              style: TextStyle(
                                fontSize: 16.8,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Container(
                height: context.getHeight() * 0.15,
                width: context.getWidth() * 0.3 - 10,
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/imfi.jpeg"),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
