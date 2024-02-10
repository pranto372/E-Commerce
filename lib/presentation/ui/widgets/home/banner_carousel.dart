import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/banner_item.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({
    super.key, required this.height, required this.bannerList,
  });

  final double? height;
  final List<BannerItem> bannerList;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height ?? 180.0,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            viewportFraction: 1,
            autoPlay: true,
            // autoPlayInterval: Duration(),
            // autoPlayAnimationDuration: Duration()
          ),
          items: widget.bannerList.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(banner.image ?? ''), fit: BoxFit.fitHeight,)),
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              banner.title ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          SizedBox(
                            width: 100,
                            child: Text(
                              banner.shortDes ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 6,),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i = 0; i < widget.bannerList.length; i++)
                  Container(
                    height: 14,
                    width: 14,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: i == _currentIndex.value ? AppColors.primaryColor : Colors.white,
                      border: Border.all(
                        color: i == _currentIndex.value ? AppColors.primaryColor : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                  )
              ],
            );
          }
        )
      ],
    );
  }
}
