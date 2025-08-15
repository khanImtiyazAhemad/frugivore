import 'package:flutter/material.dart';
import 'package:frugivore/widgets/custom.dart';

class BreadCrumbsBar extends StatelessWidget {
  final String? category;
  final String? subcategory;
  final String? product;
  final bool? bottom;
  const BreadCrumbsBar(
      {super.key, this.category, this.subcategory, this.product, this.bottom = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: p10,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: bottom! ? 0 : 10),
      color: borderColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Home",style: TextStyle(fontSize: 12)),
          if (category != null && category != "")
            Text(" / $category",
                maxLines: 1,
                softWrap: false,
                    style: TextStyle(fontSize: 12)),
          if (subcategory != null && subcategory != "")
             Text(" / $subcategory",
                maxLines: 1,
                softWrap: false,
                    style: TextStyle(fontSize: 12)),
          if (product != null && product != "")
            Expanded(
                child: Text(" / $product",
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
