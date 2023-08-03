import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/product_cubit/products_cubit.dart';
import 'package:food/screens/home/main_food_page.dart';
import 'package:food/screens/splash/splash_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit()..fetchProducts(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
