import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final void Function(int? index) onChanged;
  final int? value;
  final Color color;
  final Icon filledStar;
  final Icon unfilledStar;
  const StarRating(
      {super.key, 
      this.value = 0,
      required this.filledStar,
      required this.unfilledStar,
      required this.color,
      required this.onChanged})
      : assert(value != null);
  @override
  Widget build(BuildContext context) {
    final size = 24.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          onPressed: () => onChanged(value == index + 1 ? index : index + 1),
          color: index < value! ? color : null,
          iconSize: size,
          icon: index < value! ? filledStar : unfilledStar,
          padding: EdgeInsets.all(0),
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}

// class StarDisplay extends StarDisplayWidget {
//   const StarDisplay({required  int value = 0})
//   : super(
//     key: key,
//     value: value,
//     filledStar: const Icon(Icons.star),
//     unfilledStar: const Icon(Icons.star_border),
//   );
// }
