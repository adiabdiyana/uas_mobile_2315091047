import 'package:flutter/material.dart';

class WasteCategoryScreen extends StatelessWidget {
  const WasteCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Sampah'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CategoryCard(
            title: 'Organik',
            color: Colors.brown,
            imagePath: 'assets/organic_waste.jpeg',
            description: 'Sampah yang berasal dari makhluk hidup seperti sisa makanan, daun, ranting, dan bahan alami lainnya. Dapat diolah menjadi kompos.',
            examples: 'Contoh: Sisa sayuran, buah busuk, daun kering, ampas teh/kopi',
          ),
          _CategoryCard(
            title: 'Plastik',
            color: Colors.blue,
            imagePath: 'assets/plastic_waste.jpeg',
            description: 'Material sintetis yang sulit terurai. Harus dibersihkan sebelum didaur ulang. Hindari plastik sekali pakai.',
            examples: 'Contoh: Botol minum, kantong plastik, wadah makanan, sedotan',
          ),
          _CategoryCard(
            title: 'Kertas',
            color: Colors.orange,
            imagePath: 'assets/paper_waste.jpeg',
            description: 'Produk berbahan dasar pulp kayu. Dapat didaur ulang 5-7 kali sebelum seratnya rusak.',
            examples: 'Contoh: Koran, kardus, buku, kertas kemasan',
          ),
          _CategoryCard(
            title: 'Logam',
            color: Colors.grey,
            imagePath: 'assets/metal_waste.jpeg',
            description: 'Bahan yang dapat didaur ulang tanpa batas. Nilai ekonomis tinggi. Pastikan dalam keadaan bersih.',
            examples: 'Contoh: Kaleng minuman, panci rusak, tutup botol, kawat',
          ),
          _CategoryCard(
            title: 'Kaca',
            color: Colors.green,
            imagePath: 'assets/glass_waste.jpeg',
            description: 'Material yang 100% bisa didaur ulang tanpa mengurangi kualitas. Pecahan kaca harus dibungkus rapi.',
            examples: 'Contoh: Botol minuman, toples, gelas pecah, vas bunga',
          ),
          _CategoryCard(
            title: 'B3 (Bahan Berbahaya)',
            color: Colors.red,
            imagePath: 'assets/b3_waste.jpeg',
            description: 'Sampah beracun dan berbahaya. Tidak boleh dibuang sembarangan. Harus ke drop point khusus.',
            examples: 'Contoh: Baterai, lampu neon, obat kadaluarsa, elektronik rusak',
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imagePath;
  final String description;
  final String examples;

  const _CategoryCard({
    required this.title,
    required this.color,
    required this.imagePath,
    required this.description,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
                onError: (exception, stackTrace) => const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    examples,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}