import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigasi ke halaman pengaturan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Bagian Header Profil
            _buildProfileHeader(),
            const SizedBox(height: 24),
            
            // Statistik Kontribusi
            _buildContributionStats(),
            const SizedBox(height: 24),
            
            // Riwayat Aktivitas
            _buildActivityHistory(),
            const SizedBox(height: 24),
            
            // Menu Pengaturan
            _buildSettingsMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_photo.png'),
          child: Icon(Icons.person, size: 40), 
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Abdiyana',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Pengguna sejak ${DateFormat('MMMM y').format(DateTime(2023, 1))}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Chip(
              label: const Text('Level 3 - Eco Warrior'),
              backgroundColor: Colors.green[100],
              labelStyle: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContributionStats() {
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
              'Kontribusi Daur Ulang',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('12.5', 'kg Plastik'),
                _buildStatItem('8.2', 'kg Kertas'),
                _buildStatItem('5.7', 'kg Logam'),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.65,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 8),
            const Text(
              '65% menuju target bulanan',
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
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildActivityHistory() {
    final activities = [
      _ActivityItem(
        icon: Icons.recycling,
        title: 'Drop-off 2.3 kg plastik',
        subtitle: 'TPS Teratai, 15 Juni 2023',
        color: Colors.blue,
      ),
      _ActivityItem(
        icon: Icons.eco,
        title: 'Menyelesaikan Eco Challenge',
        subtitle: 'Hemat air selama 7 hari',
        color: Colors.green,
      ),
      _ActivityItem(
        icon: Icons.bookmark,
        title: 'Menyimpan 5 tips baru',
        subtitle: '12 Juni 2023',
        color: Colors.orange,
      ),
      _ActivityItem(
        icon: Icons.thumb_up,
        title: 'Mendapat 15 poin reputasi',
        subtitle: 'Dari kontribusi komunitas',
        color: Colors.purple,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aktivitas Terkini',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ...activities.map((activity) => _buildActivityTile(activity)),
              ListTile(
                title: const Text(
                  'Lihat Semua Aktivitas',
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  // Navigasi ke halaman aktivitas lengkap
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTile(_ActivityItem activity) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: activity.color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(activity.icon, color: activity.color),
      ),
      title: Text(activity.title),
      subtitle: Text(activity.subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pengaturan Akun',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSettingsItem(Icons.edit, 'Edit Profil'),
              _buildSettingsItem(Icons.notifications, 'Notifikasi'),
              _buildSettingsItem(Icons.privacy_tip, 'Privasi'),
              _buildSettingsItem(Icons.help_outline, 'Bantuan'),
              _buildSettingsItem(Icons.logout, 'Keluar', isLogout: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.black),
      ),
      trailing: isLogout ? null : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Aksi ketika item diklik
      },
    );
  }
}

class DateFormat {
  DateFormat(String s);
  
  format(DateTime dateTime) {}
}

class _ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}