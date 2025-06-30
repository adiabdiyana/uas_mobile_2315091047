import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class EcoTipsScreen extends StatefulWidget {
  const EcoTipsScreen({super.key});

  @override
  State<EcoTipsScreen> createState() => _EcoTipsScreenState();
}

class _EcoTipsScreenState extends State<EcoTipsScreen> {
  final List<EcoTip> _allTips = [];
  final List<EcoTip> _savedTips = [];
  String _selectedCategory = 'Semua';
  bool _isExpanded = false;
  int? _expandedTipId;

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  void _loadTips() {
    final categories = ['Rumah', 'Kantor', 'Belanja', 'Perjalanan'];
    final icons = [
      Icons.home,
      Icons.work,
      Icons.shopping_cart,
      Icons.directions_car
    ];

    setState(() {
      _allTips.addAll([
        EcoTip(
          id: 1,
          title: 'Kompos Sisa Makanan',
          content:
              'Gunakan sisa makanan dan sampah organik untuk membuat kompos. Cukup siapkan wadah khusus, campur dengan daun kering, dan aduk seminggu sekali. Dalam 2-3 bulan Anda akan mendapat pupuk alami!',
          category: 'Rumah',
          icon: Icons.home,
          imagePath: 'assets/compost_tip.png',
          difficulty: 2,
          isSaved: false,
        ),
        EcoTip(
          id: 2,
          title: 'Bawa Tas Belanja Sendiri',
          content:
              'Selalu bawa tas kain saat berbelanja untuk mengurangi sampah plastik. Simpan beberapa tas di mobil, tas kerja, dan dekat pintu rumah agar tidak lupa.',
          category: 'Belanja',
          icon: Icons.shopping_cart,
          imagePath: 'assets/shopping_bag_tip.png',
          difficulty: 1,
          isSaved: false,
        ),
        EcoTip(
          id: 3,
          title: 'Digital Dokumen',
          content:
              'Kurangi penggunaan kertas dengan meminta tagihan digital dan menggunakan dokumen elektronik. Jika harus mencetak, gunakan mode duplex (cetak bolak-balik).',
          category: 'Kantor',
          icon: Icons.work,
          imagePath: 'assets/digital_docs_tip.png',
          difficulty: 1,
          isSaved: false,
        ),
        EcoTip(
          id: 4,
          title: 'Isi Ulang Botol Minum',
          content:
              'Daripada membeli air mineral kemasan, bawa botol minum isi ulang. Ini bisa mengurangi ratusan botol plastik per tahun!',
          category: 'Perjalanan',
          icon: Icons.directions_car,
          imagePath: 'assets/water_bottle_tip.png',
          difficulty: 1,
          isSaved: false,
        ),
        EcoTip(
          id: 5,
          title: 'Daur Ulang Kreatif',
          content:
              'Botol plastik bisa jadi pot tanaman, kaleng bekas jadi tempat pensil, dan kardus jadi organizer. Kreativitas mengurangi sampah sekaligus menghemat uang!',
          category: 'Rumah',
          icon: Icons.home,
          imagePath: 'assets/upcycling_tip.png',
          difficulty: 3,
          isSaved: false,
        ),
      ]);
    });
  }

  List<EcoTip> get _filteredTips {
    if (_selectedCategory == 'Semua') return _allTips;
    return _allTips.where((tip) => tip.category == _selectedCategory).toList();
  }

  void _toggleSaveTip(int tipId) {
    setState(() {
      final tipIndex = _allTips.indexWhere((tip) => tip.id == tipId);
      _allTips[tipIndex].isSaved = !_allTips[tipIndex].isSaved;

      if (_allTips[tipIndex].isSaved) {
        _savedTips.add(_allTips[tipIndex]);
      } else {
        _savedTips.removeWhere((tip) => tip.id == tipId);
      }
    });
  }

  void _toggleExpandTip(int tipId) {
    setState(() {
      _expandedTipId = _expandedTipId == tipId ? null : tipId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Eco Tips'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Semua Tips'),
              Tab(text: 'Favorit Saya'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab Semua Tips
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip('Semua'),
                      ...['Rumah', 'Kantor', 'Belanja', 'Perjalanan']
                          .map((category) => _buildCategoryChip(category))
                          .toList(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredTips.length,
                    itemBuilder: (context, index) {
                      return _buildTipCard(_filteredTips[index]);
                    },
                  ),
                ),
              ],
            ),
            // Tab Favorit
            _savedTips.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bookmark_border, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Belum ada tips favorit'),
                        Text('Tap ikon bookmark untuk menyimpan', 
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _savedTips.length,
                    itemBuilder: (context, index) {
                      return _buildTipCard(_savedTips[index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(category),
        selected: _selectedCategory == category,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        selectedColor: Colors.green,
        labelStyle: TextStyle(
          color: _selectedCategory == category ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildTipCard(EcoTip tip) {
    final isExpanded = _expandedTipId == tip.id;

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(tip.icon, color: Colors.green),
            title: Text(tip.title),
            subtitle: Text(tip.category),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  3,
                  (i) => Icon(
                    i < tip.difficulty ? Icons.eco : Icons.eco_outlined,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    tip.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: tip.isSaved ? Colors.green : null,
                  ),
                  onPressed: () => _toggleSaveTip(tip.id),
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      tip.imagePath,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 120,
                        color: Colors.grey[200],
                        child: const Icon(Icons.photo),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tip.content,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${(tip.difficulty * 20) + 50}% berguna',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.share, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Icon(Icons.flag, size: 16, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          IconButton(
            icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () => _toggleExpandTip(tip.id),
          ),
        ],
      ),
    );
  }
}

class EcoTip {
  final int id;
  final String title;
  final String content;
  final String category;
  final IconData icon;
  final String imagePath;
  final int difficulty; // 1-3
  bool isSaved;

  EcoTip({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.icon,
    required this.imagePath,
    required this.difficulty,
    required this.isSaved,
  });
}