import 'package:flutter/material.dart';
import 'package:uas_mobile_2315091047/screens/waste_detail_screen.dart';

class SearchWasteScreen extends StatefulWidget {
  const SearchWasteScreen({super.key});

  @override
  State<SearchWasteScreen> createState() => _SearchWasteScreenState();
}

class _SearchWasteScreenState extends State<SearchWasteScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<WasteItem> _searchResults = [];
  List<WasteItem> _allWastes = [];

  @override
  void initState() {
    super.initState();
    _loadWasteData();
  }

  void _loadWasteData() {
    // Data sampah lengkap dengan kategori dan keterangan
    setState(() {
      _allWastes = [
        WasteItem(
          id: '1',
          name: 'Botol Plastik PET',
          category: 'Plastik',
          imagePath: 'assets/plastic_bottle.png',
          description: 'Botol plastik dengan kode resin 1 (PET/PETE)',
          sortingGuide: '1. Lepaskan tutup dan ring\n2. Bilas bersih\n3. Keringkan\n4. Tekan untuk memipihkan',
          disposalLocation: 'Bank sampah atau tempat daur ulang plastik',
        ),
        WasteItem(
          id: '2',
          name: 'Kardus Bekas',
          category: 'Kertas',
          imagePath: 'assets/cardboard.png',
          description: 'Kemasan kardus dari kertas daur ulang',
          sortingGuide: '1. Ratakan kardus\n2. Pisahkan dari bahan non-kertas\n3. Ikat jika banyak',
          disposalLocation: 'Tempat sampah kertas atau pengepul',
        ),
        WasteItem(
          id: '3',
          name: 'Kaleng Aluminium',
          category: 'Logam',
          imagePath: 'assets/aluminum_can.png',
          description: 'Kemasan minuman dari aluminium',
          sortingGuide: '1. Bilas bersih\n2. Keringkan\n3. Tekan jika memungkinkan',
          disposalLocation: 'Bank sampah yang menerima logam',
        ),
        WasteItem(
          id: '4',
          name: 'Sisa Makanan',
          category: 'Organik',
          imagePath: 'assets/food_waste.png',
          description: 'Sisa bahan makanan yang bisa terurai',
          sortingGuide: '1. Pisahkan dari kemasan\n2. Kumpulkan dalam wadah tertutup\n3. Jadikan kompos jika memungkinkan',
          disposalLocation: 'Tempat sampah organik atau komposter',
        ),
        WasteItem(
          id: '5',
          name: 'Baterai Bekas',
          category: 'B3',
          imagePath: 'assets/battery.png',
          description: 'Baterai mengandung logam berat berbahaya',
          sortingGuide: '1. Jangan dibuang sembarangan\n2. Simpan dalam wadah tertutup\n3. Bawa ke drop point khusus',
          disposalLocation: 'Drop point B3 atau toko elektronik',
        ),
      ];
    });
  }

  void _searchWaste(String query) {
    setState(() {
      _searchResults = _allWastes
          .where((waste) =>
              waste.name.toLowerCase().contains(query.toLowerCase()) ||
              waste.category.toLowerCase().contains(query.toLowerCase()) ||
              waste.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cara Memilah Sampah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Cari jenis sampah... (Contoh: botol plastik, kardus)',
              onChanged: _searchWaste,
              trailing: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchWaste(_searchController.text);
                  },
                ),
              ],
            ),
          ),
          if (_searchController.text.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori Sampah',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildCategoryChip('Plastik'),
                      _buildCategoryChip('Kertas'),
                      _buildCategoryChip('Logam'),
                      _buildCategoryChip('Organik'),
                      _buildCategoryChip('Kaca'),
                      _buildCategoryChip('B3'),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildCategoryExamples()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return ActionChip(
      label: Text(category),
      onPressed: () {
        _searchController.text = category;
        _searchWaste(category);
      },
      backgroundColor: _getCategoryColor(category),
    );
  }

  Widget _buildCategoryExamples() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Contoh Jenis Sampah',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._allWastes.take(5).map((waste) => _buildWasteTile(waste)).toList(),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tidak ditemukan hasil pencarian'),
            Text('Coba kata kunci lain', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildWasteTile(_searchResults[index]);
      },
    );
  }

  Widget _buildWasteTile(WasteItem waste) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WasteDetailScreen(wasteItem: waste),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getCategoryColor(waste.category).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  waste.imagePath,
                  errorBuilder: (_, __, ___) => Icon(Icons.recycling, color: _getCategoryColor(waste.category)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      waste.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      waste.category,
                      style: TextStyle(
                        color: _getCategoryColor(waste.category),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      waste.description,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Plastik':
        return Colors.blue;
      case 'Kertas':
        return Colors.orange;
      case 'Logam':
        return Colors.grey;
      case 'Organik':
        return Colors.brown;
      case 'Kaca':
        return Colors.green;
      case 'B3':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class WasteItem {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final String description;
  final String sortingGuide;
  final String disposalLocation;

  WasteItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.description,
    required this.sortingGuide,
    required this.disposalLocation,
  });
}