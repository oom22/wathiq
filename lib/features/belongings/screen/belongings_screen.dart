import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'belongings_details_screen.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class BelongingsScreen extends StatelessWidget {

  final List<Map<String, dynamic>> properties = [
    {
      "type": "الشقق",
      "units": 35,
      "image": "assets/images/apartment.png",
      "icon": Icons.apartment,
    },
    {
      "type": "الفلل",
      "units": 12,
      "image": "assets/images/villa.png",
      "icon": Icons.house_rounded,
    },
    {
      "type": "التجاري",
      "units": 8,
      "image": "assets/images/t.png",
      "icon": Icons.business,
    },
    {
      "type": "الأراضي",
      "units": 20,
      "image": "assets/images/land.png",
      "icon": Icons.map,
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0C3F45),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3F45),
        title:  Text(
          "الأملاك",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding:  EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff939CA4),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "تصفية",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      hintText: "شقق مفروشة",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Swiper(
              itemCount: properties.length,
              layout: SwiperLayout.STACK,
              itemWidth: MediaQuery.of(context).size.width * 0.75,
              itemHeight: MediaQuery.of(context).size.height * 0.55,
              itemBuilder: (context, index) {
                final property = properties[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                BelongingsDetailsScreen(type: property["type"]),
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
                        Image.asset(
                          property["image"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),

                        Positioned(
                          top: 40,
                          right: 40,
                          child: Column(
                            children: [
                              Text(
                                property["type"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "(صك ${property["units"]})",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 40,
                          right: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        property["icon"],
                                        color: AppColors.primary,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(width: 15),

                                    const Text(
                                      "عرض التفاصيل",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
