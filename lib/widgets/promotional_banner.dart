import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/models/home.dart';
import 'package:frugivore/models/subcategory.dart' as model;

import 'package:frugivore/utils.dart';
import 'package:frugivore/widgets/custom.dart';

class HomePromotionalContainer extends StatelessWidget {
  final Promotional item;
  const HomePromotionalContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxTopBottomBorderDecoration,
      child: item.counter == 4
          ? Column(
              children: [
                Row(children: [
                  Expanded(
                      child: BannerContainer(
                          image: item.bannerThree,
                          url: item.redirectionUrlThree)),
                  Expanded(
                      child: BannerContainer(
                          image: item.bannerTwo, url: item.redirectionUrlTwo)),
                ]),
                Row(children: [
                  Expanded(
                      child: BannerContainer(
                          image: item.bannerOne, url: item.redirectionUrlOne)),
                  Expanded(
                      child: BannerContainer(
                          image: item.banner, url: item.redirectionUrl)),
                ]),
              ],
            )
          : item.counter == 3
              ? Column(
                  children: [
                    BannerContainer(
                        image: item.bannerTwo, url: item.redirectionUrlTwo),
                    Row(
                      children: [
                        Expanded(
                            child: BannerContainer(
                                image: item.bannerOne,
                                url: item.redirectionUrlOne)),
                        Expanded(
                            child: BannerContainer(
                                image: item.banner, url: item.redirectionUrl)),
                      ],
                    ),
                  ],
                )
              : item.counter == 2
                  ? Row(
                      children: [
                        Expanded(
                            child: BannerContainer(
                                image: item.bannerOne,
                                url: item.redirectionUrlOne)),
                        Expanded(
                            child: BannerContainer(
                                image: item.banner, url: item.redirectionUrl)),
                      ],
                    )
                  : BannerContainer(
                      image: item.banner, url: item.redirectionUrl),
    );
  }
}

class SubCategoryPromotionalContainer extends StatelessWidget {
  final model.Promotional item;
  const SubCategoryPromotionalContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxTopBottomBorderDecoration,
      child: BannerContainer(image: item.banner, url: item.redirectionUrl),
    );
  }
}

class BannerContainer extends StatelessWidget {
  final String? image;
  final String? url; 
  const BannerContainer({super.key, required this.image, required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: image!,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      onTap: () => PromotionBannerRouting(url: url!).routing(),
    );
  }
}
