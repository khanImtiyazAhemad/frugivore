import "package:flutter/material.dart";

Color yellowColor = Color(0xffffc107);
Color darkGrey = Color(0xff787878);
Color backgroundGrey = Color(0xffB3B6B7);
Color whiteColor = Color(0xffffffff);
Color primaryColor = Color(0xff80956d);
Color darkGreen = Color(0xff2ECC71);
Color packageColor = Color(0xff006400);
Color pinkColor = Color(0xffE74C3C);
Color skyBlueColor = Color(0xff3498DB);
Color lightSkyBlueColor = Color(0xff8EC5FF);
Color greenOriginalsColor = Color(0xff28B463);
Color orangeColor = Color(0xffe96125);
Color borderColor = Color(0xffd3d3d3);
Color bodyColor = Color(0xffe6e6e6);
Color whatsFreeColor = Color(0xff68b956);
Color lightRedColor = Color(0xffFF6467);

double buttonHeight = 40.0;

ShapeDecoration shapeDecoration = ShapeDecoration(
  shape: RoundedRectangleBorder(
    side: BorderSide(width: 1.0, style: BorderStyle.solid, color: borderColor),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

RoundedRectangleBorder shapeRoundedRectangleBorderBLR = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
);

RoundedRectangleBorder roundedCircularRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(5)),
);
RoundedRectangleBorder roundedHalfCircularRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
);

RoundedRectangleBorder shapeRoundedRectangleBorderBLTL = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
);

RoundedRectangleBorder shapeRoundedRectangleBorderBRTR = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
);

RoundedRectangleBorder shapeRoundedRectangleZeroBorderRadius =
    RoundedRectangleBorder(
  borderRadius: BorderRadius.zero,
);

BoxDecoration boxTopBottomBorderDecoration = BoxDecoration(
  border: Border(
      top: BorderSide(color: borderColor),
      // bottom: BorderSide(color: borderColor)
      )
);


BoxDecoration boxDecoration = BoxDecoration(
  border: Border.all(color: borderColor),
  borderRadius: BorderRadius.circular(5),
);

BoxDecoration loginBoxDecoration = BoxDecoration(
  border: Border.all(color: borderColor),
  borderRadius: BorderRadius.circular(15),
);

BoxDecoration boxRadius = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
);

BoxDecoration semiCircleboxDecoration = BoxDecoration(
  border: Border.all(color: borderColor),
  borderRadius: BorderRadius.circular(50),
);

BoxDecoration boxDecorationlbrBorder = BoxDecoration(
  border: Border(
      left: BorderSide(color: borderColor),
      bottom: BorderSide(color: borderColor),
      right: BorderSide(color: borderColor)),
);
BoxDecoration boxDecorationBottomBorder = BoxDecoration(
  border: Border(bottom: BorderSide(color: borderColor)),
);

BoxDecoration cartLeftButton = BoxDecoration(
  color: pinkColor,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
);

BoxDecoration cartMessageBox = BoxDecoration(
  color: pinkColor,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
);


BoxDecoration preOrderLeftButton = BoxDecoration(
  color: packageColor,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
);
BoxDecoration cartRightButton = BoxDecoration(
  color: pinkColor,
  borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
);

BoxDecoration preOrderRightButton = BoxDecoration(
  color: packageColor,
  borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
);
BoxDecoration boxDecorationWithBorder = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(5),
  ),
);
BoxDecoration circularBoxDecorationWithBorder = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10))
);

BoxDecoration semicircularBoxDecorationWithBorder = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(5))
);

BoxDecoration topsemicircularBoxDecorationWithBorder = BoxDecoration(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
);

BoxDecoration paymentboxDecorationWithBorder = BoxDecoration(
  border: Border.all(color: borderColor),
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  ),
);

BoxDecoration boxDecorationWithOutRadius = BoxDecoration(
  border: Border.all(color: borderColor),
);

ButtonStyle customElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    minimumSize: Size(60, 32),
  );
}

ButtonStyle customViewElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(2,0,2,0),
    minimumSize: Size(30, 30),
  );
}

ButtonStyle rechargeNowCustomElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    minimumSize: Size.fromHeight(40),
  );
}

ButtonStyle cartRechargeNowCustomElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    minimumSize: const Size.fromHeight(40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Not circular
    ),
  );
}


ButtonStyle customCircularElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    minimumSize: Size(60, 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );
}
ButtonStyle customNonSlimmerElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
  );
}

ButtonStyle referCustomElevatedButton(primary, onPrimary, side) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    side: BorderSide(color: side),
    shape: StadiumBorder(),
  );
}

ButtonStyle notifyMeCustomElevatedButton(primary, onPrimary, side) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    side: BorderSide(color: side),
    minimumSize: Size(60, 34)
  );
}

ButtonStyle recentPurchaseCustomElevatedButton(primary, onPrimary) {
  return ElevatedButton.styleFrom(
    backgroundColor: primary, 
    foregroundColor: onPrimary,
    shadowColor: Color(0x00ffffff),
    elevation: 0.1,
    padding: EdgeInsets.fromLTRB(10,0,10,0),
    minimumSize: Size(60, 34)
  );
}

EdgeInsets p2 = EdgeInsets.all(2);
EdgeInsets plr2 = EdgeInsets.only(left: 2, right: 2);
EdgeInsets ptb2 = EdgeInsets.only(top: 2, bottom: 2);
EdgeInsets ptlr2 = EdgeInsets.only(top: 2, left: 2, right: 2);
EdgeInsets plbr2 = EdgeInsets.only(left: 2, bottom: 2, right: 2);

EdgeInsets p5 = EdgeInsets.all(5);
EdgeInsets pr5 = EdgeInsets.only(right:5);
EdgeInsets pt5 = EdgeInsets.only(top: 5);
EdgeInsets plr5 = EdgeInsets.only(left: 5, right: 5);
EdgeInsets ptb5 = EdgeInsets.only(top: 5, bottom: 5);
EdgeInsets ptlr5 = EdgeInsets.only(top: 5, left: 5, right: 5);
EdgeInsets plbr5 = EdgeInsets.only(left: 5, bottom: 5, right: 5);

EdgeInsets p10 = EdgeInsets.all(10);
EdgeInsets pr10 = EdgeInsets.only(right:10);
EdgeInsets pt10 = EdgeInsets.only(top: 10);
EdgeInsets plr10 = EdgeInsets.only(left: 10, right: 10);
EdgeInsets ptb10 = EdgeInsets.only(top: 10, bottom: 10);
EdgeInsets ptlr10 = EdgeInsets.only(top: 10, left: 10, right: 10);
EdgeInsets plbr10 = EdgeInsets.only(left: 10, bottom: 10, right: 10);

EdgeInsets p15 = EdgeInsets.all(15);
EdgeInsets pr15 = EdgeInsets.only(right:15);
EdgeInsets plr15 = EdgeInsets.only(left: 15, right: 15);
EdgeInsets ptb15 = EdgeInsets.only(top: 15, bottom: 15);
EdgeInsets ptlr15 = EdgeInsets.only(top: 15, left: 15, right: 15);
EdgeInsets plbr15 = EdgeInsets.only(left: 15, bottom: 15, right: 15);

EdgeInsets p20 = EdgeInsets.all(20);
EdgeInsets pr20 = EdgeInsets.only(right:20);
EdgeInsets pt20 = EdgeInsets.only(top: 20);
EdgeInsets plr20 = EdgeInsets.only(left: 20, right: 20);
EdgeInsets ptb20 = EdgeInsets.only(top: 20, bottom: 20);
EdgeInsets ptlr20 = EdgeInsets.only(top: 20, left: 20, right: 20);
EdgeInsets plbr20 = EdgeInsets.only(left: 20, bottom: 20, right: 20);

EdgeInsets p7 = EdgeInsets.all(7);
EdgeInsets p8 = EdgeInsets.all(8);
