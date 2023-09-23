import 'package:flutter/material.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  @override
  _PaymentMethodBottomSheetState createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  int selectedPaymentMethod = 0; // 0 for Cash on Delivery, 1 for Khalti

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Select Payment Method:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioListTile<int>(
              title: Text('Cash on Delivery'),
              value: 0,
              groupValue: selectedPaymentMethod,
              onChanged: (int? value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            RadioListTile<int>(
              title: Text('Khalti'),
              value: 1,
              groupValue: selectedPaymentMethod,
              onChanged: (int? value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle the selected payment method here
                switch (selectedPaymentMethod) {
                  case 0:
                    // Handle Cash on Delivery
                    print('Selected Payment Method: Cash on Delivery');
                    break;
                  case 1:
                    // Handle Khalti
                    print('Selected Payment Method: Khalti');
                    break;
                  default:
                    break;
                }
                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
