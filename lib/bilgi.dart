import 'package:flutter/material.dart';

class bilgi extends StatefulWidget {
  const bilgi({super.key});

  @override
  State<bilgi> createState() => _BilgiState();
}

class _BilgiState extends State<bilgi> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color(0xffE9EFEC),
      body: SingleChildScrollView( // Burayı ekliyoruz
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSuggestionContainer(
              title: "Karbon Ayak İzi 2000 kg'den Fazla (2001-3000 kg)",
              suggestion: "Ulaşım Seçeneklerini Gözden Geçir: Araç yerine toplu taşıma, bisiklet veya yürümeyi değerlendirin. \n"
              "Yenilenebilir Enerji Kullan: Evde güneş panelleri gibi yenilenebilir enerji kaynaklarına yönelin. \n"
                  "Atık Yönetimini İyileştir: Daha fazla geri dönüşüm yaparak ve atık miktarını azaltarak çevre dostu alışkanlıklar geliştirin.",
            ),
            _buildSuggestionContainer(
              title: "Karbon Ayak İzi 3000 kg Üzerinde (3001-5000 kg)",
              suggestion: "Enerji Verimliliği: Evde enerji verimli aletler kullanarak enerji tasarrufu sağlayın. \n "
                "Vegan veya Vejetaryen Beslenmeyi Düşünün: Et tüketimini azaltarak karbon ayak izinizi önemli ölçüde düşürebilirsiniz. \n"
                "Seyahat Planlarınızı Gözden Geçirin: Uzun mesafe uçuşlardan kaçınmayı ve yerel tatiller yapmayı düşünün." ,
            ),
            _buildSuggestionContainer(
              title: "Karbon Ayak İzi 5000 kg Üzerinde (5001 kg ve Üzeri)",
              suggestion: "Karbon Denkleştirme: Karbon dengeleme projelerine katkıda bulunarak karbon ayak izinizi dengelemeye çalışın. \n"
                  "Sıfır Atık Yaşam Tarzı: Atıkları en aza indirgeyerek ve sürdürülebilir ürünler kullanarak yaşam tarzınızı değiştirin. \n"
                  "Topluluk İnisiyatiflerine Katılın: Yerel çevre projelerine ve ağaç dikme etkinliklerine katılarak toplumsal farkındalık yaratın.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionContainer({required String title, required String suggestion}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xff16423C), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xff16423C),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            suggestion,
            style: TextStyle(
              color: const Color(0xff16423C),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
