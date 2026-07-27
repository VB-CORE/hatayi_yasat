import 'package:flutter/material.dart';

final class MerchantPanelView extends StatelessWidget {
  const MerchantPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant Panel'),
      ),
      body: const Center(
        child: Text('Merchant Panel'),
      ),
    );
  }
}
