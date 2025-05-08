import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  final double currentBalance;
  final Function(double) onTransfer;

  const TransferScreen({
    super.key,
    required this.currentBalance,
    required this.onTransfer,
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    return 'Rp. ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nomor Rekening Penerima',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _recipientController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nomor rekening',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor rekening tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'Nomor rekening minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Jumlah Transfer',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: 'Rp. ',
                  hintText: 'Masukkan jumlah transfer',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah transfer tidak boleh kosong';
                  }
                  final amount = double.tryParse(value) ?? 0;
                  if (amount <= 0) {
                    return 'Jumlah transfer harus lebih dari 0';
                  }
                  if (amount > widget.currentBalance) {
                    return 'Saldo tidak mencukupi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Catatan (Opsional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: Untuk pembayaran SPP',
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.parse(_amountController.text);
                      widget.onTransfer(amount);
                      
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Transfer Berhasil'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_formatCurrency(amount)),
                              Text('Ke: ${_recipientController.text}'),
                              if (_noteController.text.isNotEmpty)
                                Text('Catatan: ${_noteController.text}'),
                              const SizedBox(height: 10),
                              Text(
                                'Saldo Anda: ${_formatCurrency(widget.currentBalance - amount)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Tutup dialog
                                Navigator.pop(context); // Kembali ke menu utama
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'TRANSFER',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}