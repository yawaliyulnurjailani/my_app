import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../assets/style/custom_style.dart';
import '../../components/hover_scale_wrap_comp.dart';
import '../../components/slide_fade_on_visible_comp.dart';
import '../../controllers/theme_controller.dart';

class MainProjectView extends StatefulWidget {
  const MainProjectView({super.key});

  @override
  State<MainProjectView> createState() => _MainProjectViewState();
}

class _MainProjectViewState extends State<MainProjectView> {
  final ThemeController _theme = Get.find();

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  final List<Map<String, dynamic>> projectList = [
    {
      "confidential": false,
      "image": "approval_relasi_pancang.png",
      "title": "Approval Relasi Pancang",
      "description":
          "Aplikasi ini dirancang untuk memudahkan pemimpin departemen dalam mengambil keputusan cepat tanpa harus hadir secara fisik di kantor. Melalui aplikasi mobile berbasis Flutter yang mendukung Android dan iOS, pengguna dapat menerima notifikasi permintaan approval, melihat detail data yang diajukan, menyetujui atau menolak langsung dari perangkat mereka, serta memantau status proses secara menyeluruh. Fitur ini sangat membantu meningkatkan efisiensi kerja dan fleksibilitas pimpinan dalam mengelola tugas dari lokasi manapun",
      "url":
          "https://play.google.com/store/apps/details?id=com.rsup.approvalrelasipancang",
      "buttonText": "Lihat Proyek",
      "icon": Icons.arrow_forward,
    },
    {
      "confidential": false,
      "image": "e-buletin.png",
      "title": "e-buletin Sambu Group",
      "description":
          "e-buletin Kelapa Rakyat merupakan media komunikasi internal perusahaan milik Sambu Group. e-Bulletin untuk Buletin Kelapa Rakyat hanya dapat diakses melalui aplikasi e-Buletin yang dibuat dan dikembang secara internal oleh Sambu Group. informasi yang terdapat dalam e-buletin Kelapa Rakyat adalah untuk tujuan khusus, yakni menyiarkan berbagai kegiatan korporasi dalam bentuk rubrikasi artikel kepada karyawan dan tenaga kerja Sambu Group. Sehingga tidak untuk dibagikan kepada pihak lain yang tidak memiliki akses atas Bulletin Kelapa Rakyat. Karenanya setiap penyalahgunaan baik sengaja maupun tidak, yang merugikan dan berdampak, baik kecil maupun besar, akan ditindaklanjuti oleh Sambu Group. Tidak menutup kemungkinan diproses secara hukum yang berlaku di Indonesia.",
      "url":
          "https://play.google.com/store/apps/details?id=com.sambu.buletinkelaparakyat",
      "buttonText": "Lihat Proyek",
      "icon": Icons.arrow_forward,
    },
    {
      "confidential": true,
      "image": "wms.png",
      "title": "WMS (Warehouse Management System)",
      "description":
          "Aplikasi ini dirancang untuk membantu bagian logistik dan gudang dalam memantau serta mengelola posisi penyimpanan produk di dalam gudang secara lebih terstruktur. Sistem menyediakan tampilan visual dari layout gudang yang memungkinkan pengguna untuk melihat lokasi pasti dari setiap produk berdasarkan zona, rak, dan slot penyimpanan. Selain itu, sistem juga memungkinkan pemindahan posisi barang, pencatatan stok secara real-time, dan pencarian produk berdasarkan berbagai kriteria. Dengan adanya pemetaan visual ini, proses pelacakan, penataan ulang, dan pengambilan barang menjadi lebih cepat dan efisien, serta meminimalisir kesalahan penempatan.",
      "url": null,
      "buttonText": "Lihat Proyek",
      "icon": Icons.arrow_forward,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomStyle.conditionDevice(context)
        ? _buildMobileLayout()
        : _buildWebLayout());
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: -300,
            child: _buildTitle(),
          ),
          const SizedBox(height: 50),
          ...projectList.map(_buildMobileItem).toList(),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: 0,
            duration: const Duration(seconds: 5),
            child: _buildTitle(),
          ),
          const SizedBox(height: 80),
          ...projectList.map(_buildWebItem).toList(),
        ],
      ),
    );
  }

  Widget _buildWebItem(Map<String, dynamic> project) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: HoverScaleWrapper(
        scale: 1.01,
        onTap: project['url'] != null ? () => _launchURL(project['url']) : null,
        child: SlideFadeOnVisibleComp(
          enableReverse: true,
          offsetX: 0,
          duration: const Duration(seconds: 5),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _theme.getSoftContainerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(project['image']),
                const SizedBox(width: 50),
                Expanded(
                  child: _buildDescription(
                    project,
                    CrossAxisAlignment.start,
                    TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileItem(Map<String, dynamic> project) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: HoverScaleWrapper(
        scale: 1.03,
        child: SlideFadeOnVisibleComp(
          enableReverse: true,
          offsetX: -300,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _theme.getSoftContainerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildImage(project['image']),
                const SizedBox(height: 40),
                _buildDescription(
                    project, CrossAxisAlignment.center, TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageName) {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: _theme.getSoftContainerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        "${CustomStyle.urlImage}/$imageName",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget _buildDescription(Map<String, dynamic> project, caa, textAlign) {
    return Column(
      crossAxisAlignment: caa,
      children: [
        Text(
          project['title'],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _theme.getHighFontColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project['description'],
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 16,
            color: _theme.getSoftFontColor,
          ),
        ),
        if (!project['confidential'])
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: HoverScaleWrapper(
              scale: 1.03,
              onTap: project['url'] != null
                  ? () => _launchURL(project['url'])
                  : null,
              child: Container(
                width: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: _theme.getButtonHoverColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project['buttonText'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _theme.getSoftFontColor,
                      ),
                    ),
                    Icon(
                      project['icon'],
                      color: _theme.getSoftFontColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        HoverScaleWrapper(
          scale: 1.2,
          child: Column(
            children: [
              Text(
                "PROYEK",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: _theme.getHighFontColor,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: _theme.getSoftFontColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        HoverScaleWrapper(
          scale: 1.03,
          child: Text(
            "Berikut adalah kumpulan proyek pribadi dan klien yang saya bangun, lengkap dengan studi kasus untuk masing-masing proyek.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: _theme.getHighFontColor,
            ),
          ),
        ),
      ],
    );
  }
}
