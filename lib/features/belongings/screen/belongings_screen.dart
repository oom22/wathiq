import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:wathiq/features/theme/app_colors.dart';
import 'belongings_details_screen.dart';

class BelongingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> properties = [
    {
      "type": "الشقق",
      "units": 35,
      "image": "assets/images/apartment.png",
      "status": "للإيجار",
      "location": "حي الياسمين - الرياض",
      "street": "شارع انس بن مالك",
      "price": "60000 رس / شهرياً",
      "icon": Icons.apartment,
    },
    {
      "type": "الفلل",
      "units": 12,
      "image": "assets/images/villa.png",
      "status": "للبيع",
      "location": "حي الملقا - الرياض",
      "street": "طريق الملك فهد",
      "price": "1,200,000 رس",
      "icon": Icons.house_rounded,
    },
    {
      "type": "التجاري",
      "units": 8,
      "image": "assets/images/t.png",
      "status": "للإيجار",
      "location": "حي حطين - الرياض",
      "street": "شارع التخصصي",
      "price": "150000 رس / سنوياً",
      "icon": Icons.business,
    },
    {
      "type": "الأراضي",
      "units": 20,
      "image": "assets/images/land.png",
      "status": "للبيع",
      "location": "حي العقيق - الرياض",
      "street": "شارع العليا",
      "price": "900,000 رس",
      "icon": Icons.map,
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C3F45),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3F45),
        title: const Text(
          "الأملاك",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // مسافة فوق الكروت
          Expanded(
            child: Swiper(
              itemCount: properties.length,
              itemWidth:
                  MediaQuery.of(context).size.width * 0.75, // العرض أصغر شوي
              itemHeight:
                  MediaQuery.of(context).size.height * 0.45, // ارتفاع ثابت
              layout: SwiperLayout.STACK,
              itemBuilder: (context, index) {
                final property = properties[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BelongingsDetailsScreen(property: property),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // صورة العقار
                        Image.asset(
                          property["image"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),

                        // النص فوق
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Text(
                            "${property["type"]} (${property["units"]} صك)",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // زر التفاصيل
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  property["icon"],
                                  color: AppColors.background,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "عرض التفاصيل",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
