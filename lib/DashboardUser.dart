
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() { 
  runApp( 
    DevicePreview( 
      enabled: true, 
      builder: (context) => const DashboardApp(), 
    ), 
  ); 
} 

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class Studio {
  final String nama;
  final String kategori;
  final String harga;
  final String kapasitas;
  final String gambar;

  const Studio({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.kapasitas,
    required this.gambar,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedMenu = 0;

  static const merah = Color(0xFFED1B35);
  static const pink = Color(0xFFFFF0F2);
  static const abu = Color(0xFF9B8C90);

  final List<Studio> studios = const [
    Studio(
      nama: 'Studio Maternity',
      kategori: 'Lembut & Elegan',
      harga: 'Rp50.000/org',
      kapasitas: '2–4 org',
      gambar:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
    ),
    Studio(
      nama: 'Studio Keluarga',
      kategori: 'Hangat & Natural',
      harga: 'Rp38.000/org',
      kapasitas: '2–15 org',
      gambar:
          'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=500',
    ),
    Studio(
      nama: 'Studio Sahabat',
      kategori: 'Seru & Y2K',
      harga: 'Rp38.000/org',
      kapasitas: '2–15 org',
      gambar:
          'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=500',
    ),
    Studio(
      nama: 'Studio Wisuda',
      kategori: 'Bangga & Berkesan',
      harga: 'Rp38.000/org',
      kapasitas: '2–15 org',
      gambar:
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=500',
    ),
    Studio(
      nama: 'Studio Personal',
      kategori: 'Ekspresif & Artistik',
      harga: 'Rp45.000/org',
      kapasitas: '2–4 org',
      gambar:
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
    ),
    Studio(
      nama: 'Studio Fashion',
      kategori: 'Modern & Stylish',
      harga: 'Rp45.000/org',
      kapasitas: '2–10 org',
      gambar:
          'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=500',
    ),
    Studio(
      nama: 'Studio Couple',
      kategori: 'Romantis & Manis',
      harga: 'Rp40.000/org',
      kapasitas: '2 org',
      gambar:
          'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?w=500',
    ),
    Studio(
      nama: 'Studio Klasik',
      kategori: 'Simple & Timeless',
      harga: 'Rp35.000/org',
      kapasitas: '2–6 org',
      gambar:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=500',
    ),
    Studio(
      nama: 'Studio Kreatif',
      kategori: 'Unik & Berwarna',
      harga: 'Rp42.000/org',
      kapasitas: '2–8 org',
      gambar:
          'https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=500',
    ),
    Studio(
      nama: 'Studio Graduation',
      kategori: 'Kenangan Kelulusan',
      harga: 'Rp38.000/org',
      kapasitas: '2–15 org',
      gambar:
          'https://images.unsplash.com/photo-1523580494863-6f3031224c94?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3F3),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 390),
            color: const Color(0xFFFFFAFA),
            child: Column(
              children: [
                // Bagian yang dapat di-scroll
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // Header merah
                      SliverToBoxAdapter(
                        child: _buildHeader(),
                      ),

                      // Judul katalog
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 17, 16, 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Studio Kami',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF292326),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Katalog studio dua kolom
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return _buildStudioCard(studios[index]);
                            },
                            childCount: studios.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            mainAxisExtent: 162,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Navigasi bawah tetap terlihat
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header dashboard
  Widget _buildHeader() {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD80F2A),
            Color(0xFFFF354F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -60,
            child: Container(
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            right: -15,
            top: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 18,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'VISUAL SPACE',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              const Text(
                'Halo, Syifamaulida7!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Siap bikin kenangan baru hari ini?',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Kartu studio
  Widget _buildStudioCard(Studio studio) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          _showStudioDetail(studio);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto studio
            SizedBox(
              height: 87,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    studio.gambar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFF2E5E7),
                        child: const Icon(
                          Icons.photo_camera_outlined,
                          color: merah,
                          size: 32,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 7,
                    left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        studio.kapasitas,
                        style: const TextStyle(
                          color: merah,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Informasi studio
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 7, 5, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studio.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF302A2C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      studio.kategori,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: abu,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Mulai ${studio.harga}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: merah,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Detail studio saat kartu ditekan
  void _showStudioDetail(Studio studio) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studio.nama,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Kategori: ${studio.kategori}'),
              const SizedBox(height: 6),
              Text('Kapasitas: ${studio.kapasitas}'),
              const SizedBox(height: 6),
              Text(
                'Harga: ${studio.harga}',
                style: const TextStyle(
                  color: merah,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Studio ${studio.nama} dipilih.',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: merah,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Pilih Studio'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Navigasi bawah
  Widget _buildBottomNavigation() {
    const labels = [
      'Beranda',
      'Booking',
      'Foto Saya',
      'Profil',
    ];

    const icons = [
      Icons.home_outlined,
      Icons.calendar_month_outlined,
      Icons.photo_album_outlined,
      Icons.person_outline,
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final active = selectedMenu == index;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(13),
              onTap: () {
                setState(() {
                  selectedMenu = index;
                });

                if (index != 0) {
                  _showMessage(
                    '${labels[index]} dipilih. Halaman ini belum dibuat.',
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFFFFF0F2) : Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icons[index],
                      size: 20,
                      color: active ? merah : abu,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: active ? merah : abu,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
