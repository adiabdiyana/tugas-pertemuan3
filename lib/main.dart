import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Banking Undiksha',
      theme: ThemeData(
        primaryColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJHFMfcooJkFo9wJpYpQQj3oM5W9AcZG-Hfw&s',
              height: 100,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuUtamaPage()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: Text('Daftar Mbanking'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('lupa password?'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('copyright @2025 by Abdiyana'),
          ],
        ),
      ),
    );
  }
}

class MenuUtamaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Utama'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Koperasi Undiksha',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                child: Text('IA'),
              ),
              title: Text('I Ketut Adi Abdiyana'),
              subtitle: Text('Total Saldo Anda\nRp. 14.120.240'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildMenuButton(Icons.money_off, 'Cek Saldo', () {}),
                _buildMenuButton(Icons.send, 'Transfer', () {}),
                _buildMenuButton(Icons.attach_money, 'Deposito', () {}),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildMenuButton(Icons.payment, 'Pembayaran', () {}),
                _buildMenuButton(Icons.receipt, 'Pinjaman', () {}),
                _buildMenuButton(Icons.history, 'Mutasi', () {}),
              ],
            ),
            SizedBox(height: 20),
            Text('Butuh Bantuan?\n0831-1726-3525'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildMenuButton(Icons.settings, 'Setting', () {}),
                _buildMenuButton(Icons.grid_view, '', () {}),
                _buildMenuButton(Icons.person, 'Profile', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: <Widget>[
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        Text(label),
      ],
    );
  }
}