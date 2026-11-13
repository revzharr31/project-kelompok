import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() { 
  runApp( 
    DevicePreview( 
      enabled: true, 
      builder: (context) => const StudioDetailApp(), 
    ), 
  ); 
} 

class StudioDetailApp extends StatelessWidget {
  const StudioDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeskripsiStudioPage(),
    );
  }
}

// Data studio.
// Nantinya bagian ini dapat diganti dengan data dari database admin.
class StudioData {
  final String nama;
  final String kategori;
  final String gambar;
  final String deskripsi;
  final int kapasitasMin;
  final int kapasitasMax;
  final int durasi;
  final int jumlahFoto;
  final int hargaPerOrang;
  final int dpPersen;
  final List<String> fasilitas;
  final List<String> properti;
  final List<String> ketentuan;

  const StudioData({
    required this.nama,
    required this.kategori,
    required this.gambar,
    required this.deskripsi,
    required this.kapasitasMin,
    required this.kapasitasMax,
    required this.durasi,
    required this.jumlahFoto,
    required this.hargaPerOrang,
    required this.dpPersen,
    required this.fasilitas,
    required this.properti,
    required this.ketentuan,
  });
}

class DeskripsiStudioPage extends StatefulWidget {
  const DeskripsiStudioPage({super.key});

  @override
  State<DeskripsiStudioPage> createState() =>
      _DeskripsiStudioPageState();
}

class _DeskripsiStudioPageState
    extends State<DeskripsiStudioPage> {
  static const Color merah = Color(0xFFFF233F);
  static const Color pink = Color(0xFFFFEFF1);
  static const Color latar = Color(0xFFFFFAFA);
  static const Color abu = Color(0xFF9A898D);
  static const Color garis = Color(0xFFF0E5E7);

  // Contoh data studio maternity.
  // Data ini bisa diganti sesuai studio yang dipilih.
  final StudioData studio = const StudioData(
    nama: 'Studio Maternity',
    kategori: 'Lembut & Elegan',
    gambar:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=900',
    deskripsi:
        'Abadikan momen kehamilan dengan suasana lembut dan elegan. '
        'Studio ini dirancang untuk membantu calon ibu mengabadikan '
        'momen berharga bersama pasangan atau keluarga.',
    kapasitasMin: 2,
    kapasitasMax: 4,
    durasi: 45,
    jumlahFoto: 20,
    hargaPerOrang: 50000,
    dpPersen: 30,
    fasilitas: [
      'Pilihan pose duduk, berdiri, dan bersama pasangan',
      'Panduan pose dasar',
      'Penggunaan properti studio',
      'Akses hasil foto selama 30 hari',
    ],
    properti: [
      'Latar krem & putih',
      'Kursi kecil',
      'Kain dekoratif',
      'Bunga buatan',
      'Aksesori maternity',
    ],
    ketentuan: [
      'Maksimal 1 kali pergantian pakaian',
      'Pakaian pribadi dibawa oleh Customer',
      'Waktu berganti pakaian termasuk dalam durasi sesi',
    ],
  );

  int jumlahOrang = 2;

  int get totalHarga => jumlahOrang * studio.hargaPerOrang;

  int get jumlahDp =>
      (totalHarga * studio.dpPersen / 100).round();

  String rupiah(int angka) {
    final teks = angka.toString();
    final hasil = StringBuffer();

    for (int i = 0; i < teks.length; i++) {
      hasil.write(teks[i]);

      final sisa = teks.length - i - 1;
      if (sisa > 0 && sisa % 3 == 0) {
        hasil.write('.');
      }
    }

    return 'Rp${hasil.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      body: SafeArea(
        child: Column(
          children: [
            // Semua isi halaman dapat digeser.
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(),
                    _buildRingkasan(),
                    _buildTentangStudio(),
                    _buildFasilitas(),
                    _buildProperti(),
                    _buildKetentuan(),
                    _buildFotoDigital(),
                    _buildHarga(),
                    _buildJumlahOrang(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Tombol tetap berada di bagian bawah layar.
            _buildTombolPilih(),
          ],
        ),
      ),
    );
  }

  // Foto utama studio dan judul.
  Widget _buildHero() {
    return SizedBox(
      height: 228,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            studio.gambar,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE9DCDD),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 55,
                  color: merah,
                ),
              );
            },
          ),

          // Lapisan gelap di bagian bawah foto.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xAA000000),
                ],
                stops: [0.45, 1],
              ),
            ),
          ),

          // Tombol kembali.
          Positioned(
            top: 12,
            left: 15,
            child: Material(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(11),
              child: InkWell(
                borderRadius: BorderRadius.circular(11),
                onTap: () => Navigator.maybePop(context),
                child: const SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 17,
                    color: Color(0xFF252124),
                  ),
                ),
              ),
            ),
          ),

          // Nama dan kategori studio.
          Positioned(
            left: 16,
            right: 12,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: merah,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    studio.kategori,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  studio.nama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Informasi kapasitas, durasi, dan foto.
  Widget _buildRingkasan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          _buildInfoBox(
            'Kapasitas',
            '${studio.kapasitasMin}–${studio.kapasitasMax} orang',
          ),
          const SizedBox(width: 7),
          _buildInfoBox('Durasi', '${studio.durasi} menit'),
          const SizedBox(width: 7),
          _buildInfoBox('Hasil', '${studio.jumlahFoto} foto'),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String judul, String isi) {
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: pink,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: const Color(0xFFFFD6DC),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: const TextStyle(
                fontSize: 9,
                color: abu,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              isi,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: merah,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Deskripsi studio.
  Widget _buildTentangStudio() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tentang Studio',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF292326),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            studio.deskripsi,
            style: const TextStyle(
              fontSize: 11,
              height: 1.6,
              color: Color(0xFF827478),
            ),
          ),
        ],
      ),
    );
  }

  // Fasilitas dan benefit.
  Widget _buildFasilitas() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Fasilitas & Benefit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Termasuk Paket',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: merah,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ...studio.fasilitas.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: merah,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.4,
                        color: Color(0xFF827478),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: garis),
          const Text(
            '+ Semua fasilitas di atas termasuk dalam paket',
            style: TextStyle(
              fontSize: 9,
              color: abu,
            ),
          ),
        ],
      ),
    );
  }

  // Properti dan aksesori studio.
  Widget _buildProperti() {
    return _buildCard(
      child: Column(
        children: [
          Row(
            children: [
              _iconBulatan(Icons.weekend_outlined),
              const SizedBox(width: 9),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Properti & Aksesori',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Disesuaikan dengan konsep studio',
                      style: TextStyle(
                        fontSize: 9,
                        color: abu,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: studio.properti.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 58,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F8),
                  border: Border.all(color: garis),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _iconBulatan(
                          Icons.weekend_outlined,
                          kecil: true,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Gratis',
                            style: TextStyle(
                              color: merah,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      studio.properti[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Ketentuan pergantian pakaian.
  Widget _buildKetentuan() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconBulatan(Icons.checkroom_outlined),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Ketentuan Ganti Baju',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...studio.ketentuan.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 13,
                    color: merah,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.4,
                        color: Color(0xFF827478),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Informasi foto digital.
  Widget _buildFotoDigital() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: pink,
          border: Border.all(
            color: const Color(0xFFFFD5DB),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _iconBulatan(Icons.photo_outlined),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Foto Digital yang Kamu Dapatkan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFFA1AF),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 67,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    studio.gambar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.photo,
                        color: merah,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${studio.jumlahFoto} foto digital',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: merah,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Pilih foto favorit melalui aplikasi. '
                        'Hasil tersedia selama 30 hari.',
                        style: TextStyle(
                          fontSize: 9,
                          height: 1.5,
                          color: Color(0xFF827478),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Foto di luar kuota dapat dikenakan biaya tambahan '
                'sesuai ketentuan.',
                style: TextStyle(
                  fontSize: 9,
                  height: 1.5,
                  color: Color(0xFF827478),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Daftar harga per orang.
  Widget _buildHarga() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Harga',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Harga dihitung per orang sesuai jumlah peserta.',
            style: TextStyle(
              fontSize: 10,
              color: abu,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: pink,
              border: Border.all(color: merah),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  '${studio.kapasitasMin}–${studio.kapasitasMax} orang',
                  style: const TextStyle(
                    fontSize: 10,
                    color: merah,
                  ),
                ),
                const Spacer(),
                Text(
                  '${rupiah(studio.hargaPerOrang)}/orang',
                  style: const TextStyle(
                    fontSize: 10,
                    color: merah,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Pengaturan jumlah orang dan kalkulasi harga.
  Widget _buildJumlahOrang() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jumlah Orang',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _tombolJumlah(
                icon: Icons.remove,
                onTap: () {
                  if (jumlahOrang > studio.kapasitasMin) {
                    setState(() {
                      jumlahOrang--;
                    });
                  }
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$jumlahOrang',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: merah,
                      ),
                    ),
                    const Text(
                      'orang',
                      style: TextStyle(
                        fontSize: 10,
                        color: abu,
                      ),
                    ),
                  ],
                ),
              ),
              _tombolJumlah(
                icon: Icons.add,
                onTap: () {
                  if (jumlahOrang < studio.kapasitasMax) {
                    setState(() {
                      jumlahOrang++;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: garis),
          _barisHarga(
            'Biaya per orang',
            rupiah(studio.hargaPerOrang),
          ),
          const SizedBox(height: 9),
          _barisHarga(
            'DP ${studio.dpPersen}%',
            rupiah(jumlahDp),
          ),
          const SizedBox(height: 9),
          const Divider(
            color: Color(0xFFFFD5DB),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total keseluruhan',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                rupiah(totalHarga),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: merah,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _barisHarga(String label, String nilai) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: abu,
            ),
          ),
        ),
        Text(
          nilai,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _tombolJumlah({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor:
              icon == Icons.add ? merah : const Color(0xFFFAF7F8),
          foregroundColor:
              icon == Icons.add ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  // Tombol pilih studio di bagian bawah layar.
  Widget _buildTombolPilih() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 9, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Konfirmasi Studio'),
                  content: Text(
                    'Kamu memilih ${studio.nama} untuk '
                    '$jumlahOrang orang dengan total '
                    '${rupiah(totalHarga)}.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage(
                          'Studio dipilih. Proses booking '
                          'selanjutnya belum dihubungkan.',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: merah,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Lanjut'),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: merah,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: const Color(0xFFFFD5DB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: const Text(
            'Pilih Studio Ini',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: garis),
        borderRadius: BorderRadius.circular(19),
      ),
      child: child,
    );
  }

  Widget _iconBulatan(
    IconData icon, {
    bool kecil = false,
  }) {
    return Container(
      width: kecil ? 22 : 29,
      height: kecil ? 22 : 29,
      decoration: BoxDecoration(
        color: pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: kecil ? 12 : 16,
        color: merah,
      ),
    );
  }

  void _showMessage(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }
}
