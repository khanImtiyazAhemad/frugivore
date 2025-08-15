import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GetHelpController extends GetxController {
  var isLoader = true.obs;

  Future<void> launchCaller() async {
    if (await canLaunchUrl(Uri.parse("tel:8448448994"))) {
       await launchUrl(Uri.parse("tel:8448448994"));
    } else {
      throw 'Could not launch';
    }   
}


  @override
  void onInit() async {
    super.onInit();
    isLoader(false);
  }



}
