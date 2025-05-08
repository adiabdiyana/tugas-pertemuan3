import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'transfer_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  String _currentTime = '';
  double _balance = 500000000; // Saldo awal
  final String _accountName = 'I Ketut Adi Abdiyana';
  final String _accountImageUrl = 
      'https://randomuser.me/api/portraits/men/${DateTime.now().millisecondsSinceEpoch % 100}.jpg';
  final String _helpNumber = '+62 831-1940-6051';

  @override
  void initState() {
    super.initState();
    _updateTime();
    Future.delayed(const Duration(minutes: 1), _updateTime);
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour < 12 ? 'AM' : 'PM'}';
    });
  }

  void _handleTransfer(double amount) {
    setState(() {
      _balance -= amount;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transfer berhasil: Rp. ${_formatNumber(amount)}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleReceive(double amount) {
    setState(() {
      _balance += amount;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menerima uang: Rp. ${_formatNumber(amount)}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Koperasi Undiksha'),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text(_currentTime)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card Informasi Nasabah
              _buildAccountInfoCard(),
              const SizedBox(height: 20),
              
              // Menu Utama (3 kolom)
              _buildMainMenuGrid(),
              const SizedBox(height: 20),
              
              // Menu Tambahan (3 kolom)
              _buildSecondaryMenuGrid(),
              const SizedBox(height: 20),
              
              // Card Bantuan
              _buildHelpCard(),
              const SizedBox(height: 20),
              
              // Menu Pengaturan
              _buildSettingsList(),
              const SizedBox(height: 20),
              
              // Tombol Logout
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk card informasi akun
  Widget _buildAccountInfoCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(_accountImageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nasabah',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _accountName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 20),
                  const Text(
                    'Total Saldo Anda',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Rp. ${_formatNumber(_balance)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menu utama (Cek Saldo, Transfer, Deposito)
  Widget _buildMainMenuGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuButton(
          icon: Icons.account_balance_wallet,
          label: 'Cek Saldo',
          onTap: () => _showBalanceDialog(context),
        ),
        _buildMenuButton(
          icon: Icons.compare_arrows,
          label: 'Transfer',
          onTap: () => _navigateToTransferScreen(context),
        ),
        _buildMenuButton(
          icon: Icons.savings,
          label: 'Deposito',
          onTap: () {},
        ),
      ],
    );
  }

  // Widget untuk menu sekunder (Pembayaran, Pinjaman, Mutasi)
  Widget _buildSecondaryMenuGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuButton(
          icon: Icons.payment,
          label: 'Pembayaran',
          onTap: () {},
        ),
        _buildMenuButton(
          icon: Icons.money,
          label: 'Pinjaman',
          onTap: () {},
        ),
        _buildMenuButton(
          icon: Icons.list_alt,
          label: 'Mutasi',
          onTap: () {},
        ),
      ],
    );
  }

  // Widget untuk card bantuan
  Widget _buildHelpCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Butuh Bantuan?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '+62 831-1940-6051',
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menu pengaturan
  Widget _buildSettingsList() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.orange),
          title: const Text('Pengaturan'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.orange),
          title: const Text('Profil'),
          onTap: () => _navigateToProfileScreen(context),
        ),
      ],
    );
  }

  // Widget untuk tombol logout
  Widget _buildLogoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
      onPressed: () => Navigator.pop(context),
      child: const Text('Logout'),
    );
  }

  // Navigasi ke TransferScreen
  void _navigateToTransferScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferScreen(
          currentBalance: _balance,
          onTransfer: _handleTransfer,
        ),
      ),
    );
  }

  // Navigasi ke ProfileScreen
  void _navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          balance: _balance,
          onReceive: _handleReceive,
          accountName: _accountName,
          accountImageUrl: _accountImageUrl,
        ),
      ),
    );
  }

  // Tampilkan dialog saldo
  void _showBalanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saldo Anda'),
        content: Text(
          'Rp. ${_formatNumber(_balance)}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol menu
  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}