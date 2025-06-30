import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'search_waste_screen.dart';
import 'waste_category_screen.dart';
import 'drop_off_location_screen.dart';
import 'eco_tips_screen.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  int _selectedIndex = 0; // Untuk bottom navigation

  // Fungsi untuk menangani klik pada fitur utama
  void _navigateToFeature(BuildContext context, String featureName) {
    switch (featureName) {
      case 'Cari Sampah':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchWasteScreen()),
        );
        break;
      case 'Kategori Sampah':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WasteCategoryScreen()),
        );
        break;
      case 'Lokasi Drop-Off':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DropOffLocationScreen()),
        );
        break;
      case 'Eco Tips':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EcoTipsScreen()),
        );
        break;
    }
  }

  // Tips harian acak
  final List<String> _dailyTips = [
    "Cuci kemasan plastik sebelum dibuang ke tempat daur ulang",
    "Pisahkan sampah elektronik dan bawa ke drop point khusus",
    "Gunakan sampah organik untuk kompos rumah tangga",
    "Bawa tas belanja sendiri untuk mengurangi sampah plastik",
    "Lipat kardus sebelum dibuang untuk menghemat ruang"
  ];

  String get _randomTip => _dailyTips[DateTime.now().day % _dailyTips.length];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WasteWise'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan statistik
            _buildUserStats(),
            const SizedBox(height: 24),

            // Fitur Utama
            const Text(
              'Fitur Utama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureGrid(context),
            const SizedBox(height: 24),

            // Tips Harian
            _buildDailyTipCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Tambahkan logika navigasi jika diperlukan
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Lokasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Kontribusi Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('12 kg', 'Plastik'),
                _buildStatItem('8 kg', 'Kertas'),
                _buildStatItem('5 kg', 'Logam'),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 8),
            const Text(
              '70% menuju target bulanan',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildFeatureCard(
          context,
          icon: Icons.search,
          title: 'Cari Sampah',
          color: Colors.blue,
          featureName: 'Cari Sampah',
        ),
        _buildFeatureCard(
          context,
          icon: Icons.category,
          title: 'Kategori Sampah',
          color: Colors.orange,
          featureName: 'Kategori Sampah',
        ),
        _buildFeatureCard(
          context,
          icon: Icons.location_on,
          title: 'Lokasi Drop-Off',
          color: Colors.red,
          featureName: 'Lokasi Drop-Off',
        ),
        _buildFeatureCard(
          context,
          icon: Icons.eco,
          title: 'Eco Tips',
          color: Colors.green,
          featureName: 'Eco Tips',
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required String featureName,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToFeature(context, featureName),
        splashColor: color.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyTipCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
                const SizedBox(width: 8),
                const Text(
                  'Tips Hari Ini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _randomTip,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {}); // Refresh tip dengan mengubah state
                },
                child: const Text(
                  'Tips Lainnya',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}