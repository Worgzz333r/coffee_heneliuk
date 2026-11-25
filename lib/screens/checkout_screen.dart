import 'package:material_ui/material_ui.dart';

import '../cart.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _delivery = false;
  bool _done = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _done = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформлення')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ім\'я',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Введіть ім\'я'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: '+380',
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Телефон',
                hintText: '+380XXXXXXXXX',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value != null && RegExp(r'^\+380\d{9}$').hasMatch(value)
                  ? null
                  : 'Формат: +380XXXXXXXXX',
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Доставка'),
              value: _delivery,
              onChanged: (value) => setState(() => _delivery = value),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Підтвердити · ${cart.total} грн'),
            ),
            const SizedBox(height: 24),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: _done ? 64 : 0,
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Замовлення прийнято!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
