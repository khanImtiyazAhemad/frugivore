import 'package:get/get.dart';


class FilterController extends GetxController {
  var filterOrderSelectedTab = "".obs;
  late List filterOrderSelectedTabChild;
  String filterqsp = "";

  var defaultSortOrder = "".obs;
  var defaultSortProduct = "".obs;

  static var defaultfilterPlacedDate = "".obs;
  static var defaultfilterDeliveryDate = "".obs;
  static var defaultfilterOrderStatus = "".obs;
  static var defaultfilterOrderType = "".obs;
  static RxList defaultfilterInvoices = [].obs;

  static RxList defaultCategories = [].obs;
  static RxList defaultSubCategories = [].obs;
  static RxList defaultBrands = [].obs;
  static RxList defaultPrice = [].obs;
  static RxList defaultDiscount = [].obs;
  static RxList defaultPreference = [].obs;
  static RxList defaultAvailability = [].obs;

  static RxList selectedFilters = [].obs;
  static RxList selectedOrderFilters = [].obs;

  var filterProductSelectedTab = "".obs;
  late List filterProductSelectedTabChild;

  @override
  void onInit() {
    filterOrderSelectedTab(filterOrder[0]['text']);
    filterOrderSelectedTabChild = filterOrder[0]['child'];
    defaultSortOrder(sortOrder[0]['value']);
    defaultSortProduct(sortProduct[sortProduct.length - 1]['value']);

    filterProductSelectedTab(filterProduct[0]['text']);
    filterProductSelectedTabChild = filterProduct[0]['child'];
    super.onInit();
  }

  void changeInvoices(value) {
    if (defaultfilterInvoices.contains(value)) {
      defaultfilterInvoices.remove(value);
    } else {
      defaultfilterInvoices.add(value);
    }
    fetchFilteredList();
  }

  String resultQsp() {
    String qsp = defaultSortOrder.value + fetchFilteredQSP();
    return qsp;
  }

  String resultProductQsp() {
    String qsp = defaultSortProduct.value + fetchProductFilteredQSP();
    return qsp;
  }

  String fetchFilteredQSP() {
    filterqsp = "";
    if (defaultfilterPlacedDate.value != "") {
      filterqsp += "&created_date=${defaultfilterPlacedDate.value}";
    }
    if (defaultfilterDeliveryDate.value != "") {
      filterqsp += "&delivery_date=${defaultfilterDeliveryDate.value}";
    }
    if (defaultfilterOrderStatus.value != "") {
      filterqsp += "&order_status=${defaultfilterOrderStatus.value}";
    }
    if (defaultfilterOrderType.value != "") {
      filterqsp += "&order_type=${defaultfilterOrderType.value}";
    }
    if (defaultfilterInvoices.isNotEmpty) {
      filterqsp += "&invoice=${defaultfilterInvoices.join(",")}";
    }
    return filterqsp;
  }

  String fetchFilteredList() {
    selectedOrderFilters([]);
    if (defaultfilterPlacedDate.value != "") {
      selectedOrderFilters
          .add({"name": "Placed", "value": defaultfilterPlacedDate.value});
    }
    if (defaultfilterDeliveryDate.value != "") {
      selectedOrderFilters
          .add({"name": "Delivered", "value": defaultfilterDeliveryDate.value});
    }
    if (defaultfilterOrderStatus.value != "") {
      selectedOrderFilters
          .add({"name": "Status", "value": defaultfilterOrderStatus.value});
    }
    if (defaultfilterOrderType.value != "") {
      selectedOrderFilters
          .add({"name": "Type", "value": defaultfilterOrderType.value});
    }
    if (defaultfilterInvoices.isNotEmpty) {
      for (String item in defaultfilterInvoices) {
        selectedOrderFilters.add({"name": "Invoices", "value": item});
      }
    }
    return filterqsp;
  }

  String fetchProductFilteredQSP() {
    filterqsp = "";
    if (defaultCategories.isNotEmpty) {
      filterqsp += "&categories=${defaultCategories.join(",")}";
    }
    if (defaultSubCategories.isNotEmpty) {
      filterqsp += "&subcategories=${defaultSubCategories.join(",")}";
    }
    if (defaultBrands.isNotEmpty) {
      filterqsp += "&brand=${defaultBrands.join(",")}";
    }
    if (defaultPrice.isNotEmpty) {
      filterqsp += "&price=${defaultPrice.join(",")}";
    }
    if (defaultDiscount.isNotEmpty) {
      filterqsp += "&discount=${defaultDiscount.join(",")}";
    }
    if (defaultPreference.isNotEmpty) {
      filterqsp += "&preferences=${defaultPreference.join(",")}";
    }
    if (defaultAvailability.isNotEmpty) {
      filterqsp += "&availability=${defaultAvailability.join(",")}";
    }
    return filterqsp;
  }

  void fetchProductFilteredList() {
    selectedFilters([]);
    if (defaultCategories.isNotEmpty) {
      for (String item in defaultCategories) {
        selectedFilters.add({"name": "Categories", "value": item});
      }
    }
    if (defaultSubCategories.isNotEmpty) {
      for (String item in defaultSubCategories) {
        selectedFilters.add({"name": "Subcategories", "value": item});
      }
    }
    if (defaultBrands.isNotEmpty) {
      for (String item in defaultBrands) {
        selectedFilters.add({"name": "Brands", "value": item});
      }
    }
    if (defaultPrice.isNotEmpty) {
      for (String item in defaultPrice) {
        selectedFilters.add({"name": "Price", "value": item});
      }
    }
    if (defaultDiscount.isNotEmpty) {
      for (String item in defaultDiscount) {
        selectedFilters.add({"name": "Discount", "value": item});
      }
    }
    if (defaultPreference.isNotEmpty) {
      for (String item in defaultPreference) {
        selectedFilters.add({"name": "Preference", "value": item});
      }
    }
    if (defaultAvailability.isNotEmpty) {
      for (String item in defaultAvailability) {
        selectedFilters.add({"name": "Availability", "value": item});
      }
    }
  }

  static void changeCategories(value) {
    if (defaultCategories.contains(value)) {
      defaultCategories.remove(value);
    } else {
      defaultCategories.add(value);
    }
  }

  static void changeSubCategories(value) {
    if (defaultSubCategories.contains(value)) {
      defaultSubCategories.remove(value);
    } else {
      defaultSubCategories.add(value);
    }
  }

  static void changeBrands(value) {
    if (defaultBrands.contains(value)) {
      defaultBrands.remove(value);
    } else {
      defaultBrands.add(value);
    }
  }

  static void changePrice(value) {
    if (defaultPrice.contains(value)) {
      defaultPrice.remove(value);
    } else {
      defaultPrice.add(value);
    }
  }

  static void changeDiscount(value) {
    if (defaultDiscount.contains(value)) {
      defaultDiscount.remove(value);
    } else {
      defaultDiscount.add(value);
    }
  }

  static void changePreference(value) {
    if (defaultPreference.contains(value)) {
      defaultPreference.remove(value);
    } else {
      defaultPreference.add(value);
    }
  }

  static void changeAvailability(value) {
    if (defaultAvailability.contains(value)) {
      defaultAvailability.remove(value);
    } else {
      defaultAvailability.add(value);
    }
  }

  void clearAllFilterQSP() {
    defaultfilterPlacedDate("");
    defaultfilterDeliveryDate("");
    defaultfilterOrderStatus("");
    defaultfilterOrderType("");
    defaultfilterInvoices([]);
    filterOrderSelectedTab(filterOrder[0]['text']);
    filterOrderSelectedTabChild = filterOrder[0]['child'];
  }

  void clearAllProductFilterQSP() {
    defaultCategories([]);
    defaultSubCategories([]);
    defaultBrands([]);
    defaultPrice([]);
    defaultDiscount([]);
    defaultPreference([]);
    defaultAvailability([]);
    filterProductSelectedTab(filterProduct[0]['text']);
    filterProductSelectedTabChild = filterProduct[0]['child'];
  }

  List sortOrder = [
    {"text": "Placed Date - Latest to Oldest", "value": "-created_date"},
    {"text": "Placed Date - Oldest to Latest", "value": "created_date"},
    {"text": "Delivery Date - Latest to Oldest", "value": "-delivery_date"},
    {"text": "Delivery Date - Oldest to Latest", "value": "delivery_date"},
    {"text": "Order Value - Low to High", "value": "amount_payable"},
    {"text": "Order Value - High to Low", "value": "-amount_payable"},
  ];
  List sortProduct = [
    {"text": "Popularity", "value": "popularity"},
    {"text": "Price - Low to High", "value": "price"},
    {"text": "Price - High to Low", "value": "-price"},
    {"text": "Alphabetical", "value": "name"},
    {"text": "Rupee Saving - Low to High", "value": "saving"},
    {"text": "Rupee Saving - High to Low", "value": "-saving"},
    {"text": "% Off - High to Low", "value": "-discount"},
    {"text": "Relevance", "value": ""},
  ];
  List filterOrder = [
    {
      "text": "Placed Date",
      "value": "created_date",
      "child": [
        {
          "text": "Today",
          "value": "today",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "Yesterday",
          "value": "yesterday",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "This Week",
          "value": "this-week",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "Last Week",
          "value": "last-week",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "This Month",
          "value": "this-month",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "Last Month",
          "value": "last-month",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
        {
          "text": "This Year",
          "value": "this-year",
          "type": "radio",
          "groupValue": defaultfilterPlacedDate
        },
      ]
    },
    {
      "text": "Delivery Date",
      "value": "delivery_date",
      "child": [
        {
          "text": "Today",
          "value": "today",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "Yesterday",
          "value": "yesterday",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "This Week",
          "value": "this-week",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "Last Week",
          "value": "last-week",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "This Month",
          "value": "this-month",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "Last Month",
          "value": "last-month",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
        {
          "text": "This Year",
          "value": "this-year",
          "type": "radio",
          "groupValue": defaultfilterDeliveryDate
        },
      ]
    },
    {
      "text": "Order Status",
      "value": "order_status",
      "child": [
        {
          "text": "Order Placed",
          "value": "Order Placed",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
        {
          "text": "Order Processed",
          "value": "Order Processed",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
        {
          "text": "Out for Delivery",
          "value": "Out for Delivery",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
        {
          "text": "Delivered",
          "value": "Delivered",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
        {
          "text": "Rejected",
          "value": "Rejected",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
        {
          "text": "Cancelled",
          "value": "Cancelled",
          "type": "radio",
          "groupValue": defaultfilterOrderStatus
        },
      ]
    },
    {
      "text": "Order Type",
      "value": "order_type",
      "child": [
        {
          "text": "NORMAL ORDER",
          "value": "NORMAL",
          "type": "radio",
          "groupValue": defaultfilterOrderType
        },
        {
          "text": "PARENT ORDER",
          "value": "PARENT",
          "type": "radio",
          "groupValue": defaultfilterOrderType
        },
        {
          "text": "CHILD ORDER",
          "value": "CHILD",
          "type": "radio",
          "groupValue": defaultfilterOrderType
        },
        {
          "text": "POSTPONE ORDER",
          "value": "POSTPONE",
          "type": "radio",
          "groupValue": defaultfilterOrderType
        },
        {
          "text": "PRE ORDER",
          "value": "PRE ORDER",
          "type": "radio",
          "groupValue": defaultfilterOrderType
        },
      ]
    },
    {"text": "Invoices", "value": "invoice", "child": []},
  ];

  List filterProduct = [
    {"text": "Categories", "value": "categories", "child": []},
    {"text": "Subcategories", "value": "subcategories", "child": []},
    {"text": "Brand", "value": "brand", "child": []},
    {
      "text": "Price",
      "value": "price",
      "child": [
        {
          "text": "Less than Rs 50",
          "value": "50",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        },
        {
          "text": "Rs 51 to Rs 100",
          "value": "51-100",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        },
        {
          "text": "Rs 101 to Rs 200",
          "value": "101-200",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        },
        {
          "text": "Rs 201 to Rs 500",
          "value": "201-500",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        },
        {
          "text": "Rs 501 to Rs 999",
          "value": "501-999",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        },
        {
          "text": "Rs 1000 & Above",
          "value": "1000",
          "type": "checkbox",
          "listObserver": defaultPrice,
          "callback": changePrice
        }
      ]
    },
    {
      "text": "Discount",
      "value": "discount",
      "child": [
        {
          "text": "Less than 10%",
          "value": "10",
          "type": "checkbox",
          "listObserver": defaultDiscount,
          "callback": changeDiscount
        },
        {
          "text": "10% - 20%",
          "value": "10-20",
          "type": "checkbox",
          "listObserver": defaultDiscount,
          "callback": changeDiscount
        },
        {
          "text": "20% - 50%",
          "value": "20-50",
          "type": "checkbox",
          "listObserver": defaultDiscount,
          "callback": changeDiscount
        },
        {
          "text": "More than 50%",
          "value": "50",
          "type": "checkbox",
          "listObserver": defaultDiscount,
          "callback": changeDiscount
        }
      ]
    },
    {
      "text": "Preferences",
      "value": "preferences",
      "child": [
        {
          "text": "Veg",
          "value": "True",
          "type": "checkbox",
          "listObserver": defaultPreference,
          "callback": changePreference
        },
        {
          "text": "Non Veg",
          "value": "False",
          "type": "checkbox",
          "listObserver": defaultPreference,
          "callback": changePreference
        },
      ]
    },
    {
      "text": "Availability",
      "value": "availability",
      "child": [
        {
          "text": "Out of Stock",
          "value": "Out of Stock",
          "type": "checkbox",
          "listObserver": defaultAvailability,
          "callback": changeAvailability
        },
        {
          "text": "In Stock",
          "value": "In Stock",
          "type": "checkbox",
          "listObserver": defaultAvailability,
          "callback": changeAvailability
        }
      ]
    },
  ];
}
