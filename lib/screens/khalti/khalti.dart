import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/screens/home/home_page.dart';
import 'package:food/screens/home/main_food_page.dart';
import 'package:khalti/khalti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../cubits/cubit/cart_cubit.dart';
import '../../modals/cart.dart';
import '../../repository/api_service/api_service.dart';

class KhaltiExampleApp extends StatefulWidget {
  const KhaltiExampleApp({Key? key}) : super(key: key);

  @override
  State<KhaltiExampleApp> createState() => _KhaltiExampleAppState();
}

class _KhaltiExampleAppState extends State<KhaltiExampleApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Pay Via Khalti'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Wallet Payment'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WalletPayment(),
            // Banking(paymentType: PaymentType.eBanking),
            // Banking(paymentType: PaymentType.mobileCheckout),
          ],
        ),
      ),
    );
  }
}

class WalletPayment extends StatefulWidget {
  const WalletPayment({Key? key}) : super(key: key);

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
  late final TextEditingController _mobileController, _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _pinController = TextEditingController();
    getData();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  String? Name;
  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Name = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            validator: (v) => (v?.isEmpty ?? true) ? 'Required ' : null,
            decoration: const InputDecoration(
              label: Text('Mobile Number'),
            ),
            controller: _mobileController,
          ),
          TextFormField(
            obscureText: true,
            validator: (v) => (v?.isEmpty ?? true) ? 'Required ' : null,
            decoration: const InputDecoration(
              label: Text('Khalti MPIN'),
            ),
            controller: _pinController,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () async {
              if (!(_formKey.currentState?.validate() ?? false)) return;
              final messenger = ScaffoldMessenger.maybeOf(context);
              final initiationModel = await Khalti.service.initiatePayment(
                request: PaymentInitiationRequestModel(
                  amount: 1000,
                  mobile: _mobileController.text,
                  productIdentity: 'asdfasdfaf',
                  productName: 'Apple Mac Mini',
                  transactionPin: _pinController.text,
                  productUrl: 'https://khalti.colm/bazaar/mac-mini-16-512-m1',
                ),
              );

              final otpCode = await _showOTPSentDialog();

              if (otpCode != null) {
                try {
                  final model = await Khalti.service.confirmPayment(
                    request: PaymentConfirmationRequestModel(
                      confirmationCode: otpCode,
                      token: initiationModel.token,
                      transactionPin: _pinController.text,
                    ),
                  );
                  List<Cart> cartItems =
                      (BlocProvider.of<CartCubit>(context).state as CartFetched)
                          .cart;
                  List<int> ids = [];
                  String name = "";
                  double price = 0.0;
                  String img = "";
                  int totalQuantity = 0;
                  String id = '';

                  for (var item in cartItems) {
                    var a = item.product_id;
                    ids.add(a!);
                    name += item.product ?? ""; // Concatenate product name
                    double itemPrice = double.tryParse(item.price ?? "0") ?? 0;
                    int itemQuantity =
                        item.quantity ?? 0; // No need for conversion
                    totalQuantity += itemQuantity;
                    price += itemPrice; // Concatenate price
                    name += ", ";
                    img = item.img ?? img;
                  }
                  name =
                      name.isNotEmpty ? name.substring(0, name.length - 2) : "";
                  for (var idf in ids) {
                    id += idf.toString() + ",";
                  }
                  if (id.isNotEmpty) {
                    id = id.substring(0, id.length - 1);
                  }
                  bool orderStatus = await ApiServices().addOrder(
                    name: Name!,
                    price: price,
                    quantity: totalQuantity,
                    product:
                        id, // Convert list of ints to comma-separated string
                    time: DateTime.now(),
                  );
                  if (orderStatus) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Successfully Ordered"),
                        duration: Duration(seconds: 1)));
                    Navigator.pop(context);
                  }
                } catch (e) {
                  messenger?.showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
              // List<Cart> cartItems =
              //     (BlocProvider.of<CartCubit>(context).state as CartFetched)
              //         .cart;
              // List<int> ids = [];
              // String name = "";
              // double price = 0.0;
              // String img = "";
              // int totalQuantity = 0;
              // String id = '';

              // for (var item in cartItems) {
              //   var a = item.product_id;
              //   ids.add(a!);
              //   name += item.product ?? ""; // Concatenate product name
              //   double itemPrice = double.tryParse(item.price ?? "0") ?? 0;
              //   int itemQuantity = item.quantity ?? 0; // No need for conversion
              //   totalQuantity += itemQuantity;
              //   price += itemPrice; // Concatenate price
              //   name += ", ";
              //   img = item.img ?? img;
              // }
              // name = name.isNotEmpty ? name.substring(0, name.length - 2) : "";
              // for (var idf in ids) {
              //   id += idf.toString() + ",";
              // }
              // if (id.isNotEmpty) {
              //   id = id.substring(0, id.length - 1);
              // }
              // bool orderStatus = await ApiServices().addOrder(
              //   name: Name!,
              //   price: price,
              //   quantity: totalQuantity,
              //   product: id, // Convert list of ints to comma-separated string
              //   time: DateTime.now(),
              // );
              // if (orderStatus) {
              //   // ignore: use_build_context_synchronously
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text("Successfully Ordered"),
              //       duration: Duration(seconds: 1)));
              //   Navigator.pop(context);
              // }
            },
            child: const Text('PAY '),
          ),
        ],
      ),
    );
  }

  Future<String?> _showOTPSentDialog() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? otp;
        return AlertDialog(
          title: const Text('OTP Sent!'),
          content: TextField(
            decoration: const InputDecoration(
              label: Text('OTP Code'),
            ),
            onChanged: (v) => otp = v,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, otp),
            )
          ],
        );
      },
    );
  }
}

class Banking extends StatefulWidget {
  const Banking({Key? key, required this.paymentType}) : super(key: key);

  final PaymentType paymentType;

  @override
  State<Banking> createState() => _BankingState();
}

class _BankingState extends State<Banking> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<BankListModel>(
      future: Khalti.service.getBanks(paymentType: widget.paymentType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final banks = snapshot.data!.banks;
          return ListView.builder(
            itemCount: banks.length,
            itemBuilder: (context, index) {
              final bank = banks[index];

              return ListTile(
                leading: SizedBox.square(
                  dimension: 40,
                  child: Image.network(bank.logo),
                ),
                title: Text(bank.name),
                subtitle: Text(bank.shortName),
                onTap: () async {
                  final mobile = await showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      String? mobile;
                      return AlertDialog(
                        title: const Text('Enter Mobile Number'),
                        content: TextField(
                          decoration: const InputDecoration(
                            label: Text('Mobile Number'),
                          ),
                          onChanged: (v) => mobile = v,
                        ),
                        actions: [
                          SimpleDialogOption(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context, mobile),
                          )
                        ],
                      );
                    },
                  );

                  if (mobile != null) {
                    final url = Khalti.service.buildBankUrl(
                      bankId: bank.idx,
                      amount: 1000,
                      mobile: mobile,
                      productIdentity: 'macbook-pro-21',
                      productName: 'Macbook Pro 2021',
                      paymentType: widget.paymentType,
                      returnUrl: 'https://khalti.com',
                    );
                    url_launcher.launchUrl(Uri.parse(url));
                  }
                },
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
