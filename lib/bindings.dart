import 'package:get/get.dart';
import 'package:frugivore/controllers/recipe/recipesTag.dart';

class RecipesTagBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RecipesTagController());
  }
}
