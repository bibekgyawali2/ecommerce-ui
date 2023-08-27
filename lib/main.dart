import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/product_cubit/products_cubit.dart';
import 'package:food/screens/auth/sign_in_page.dart';
import 'package:food/screens/auth/sign_up_page.dart';
import 'package:food/screens/home/food_page_body.dart';
import 'package:food/screens/home/home_page.dart';
import 'package:food/screens/home/main_food_page.dart';
import 'package:food/screens/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'cubits/cubit/cart_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    KhaltiScope(
        publicKey: 'test_public_key_7422370405404060b0e42105dcf11bc1',
        enabledDebugging: true,
        builder: (context, navKey) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProductsCubit>(
                create: (context) => ProductsCubit()..fetchProducts(),
              ),
              BlocProvider<CartCubit>(
                create: (context) => CartCubit()..fetchCart(),
              ),
            ],
            child: const MyApp(),
          );
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
