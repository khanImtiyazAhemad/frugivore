library;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

RxMap payload = {
  "address": "New Delhi, 110033",
  "cart": "0",
  "final_cart_amount": "0",
  "total_discounted_price": "0",

  "notification": "0",

  "cart_message": "",
  "sticky_offer_content": ""
}.obs;

RxMap titles = {
  "lighting_deals" : {"title": "Lightning Deals", "heading": "The clock is ticking! Deals will be closed after"},
  "categories" : {"title": "Categories", "heading": ""},
  "best_deals" : {"title": "Discover", "heading": "Uncover the best deals"},
  "past_purchases" : {"title": "Shop from your Purchases", "heading": "Your Shopping Archive"},
  "new_arrivals" : {"title": "What's New", "heading": "Explore Our Latest Additions"},
  "subcategories" : {"title": "Subcategories", "heading": ""},
  "frugivore_originals" : {"title": "Frugivore Originals", "heading": "The Frugivore Experience"},
  "fresh_products" : {"title": "Fresh Produce", "heading": "From Farm to Home in 10 Hours"},
  "grocery_products" : {"title": "Most Loved Groceries", "heading": "Everyday Favorites"},
  "suggested_for_you" : {"title": "Your Favorites", "heading": "Based on your recent purchases"},
  "explore_more" : {"title": "And There's More", "heading": "Explore What's Hidden"},
  "blogs" : {"title": "Engage", "heading": ""},
}.obs;

// const String baseuri = "http://localhost:8000/";
const String baseuri = "https://api.frugivore.in/";
// const String baseuri = "https://staging.frugivore.in/";
const String webUri = "https://frugivore.in/";

const String backenduri = "api/v3/";

// const String RAZOR_API_KEY = "rzp_test_aoomjIiMSQHjTp";
const String razorApiKey = "rzp_live_DrrKfu6b2nBSqe";

List cities = [
  "Faridabad",
  "Noida",
  "Ghaziabad",
  "New Delhi",
  "Gurugram",
  // "Bahadurgarh",
  // "Sonepath"
];
List businessEnquiriesList = [
  "Hotels",
  "Restaurants",
  "Caterers",
  "Institutions",
  "General Store",
  "Others",
];
List subscriptionCustomOccurance = ["Days", "Weeks", "Months"];
List helpOrderitems = ["Select your Preference", "Replacement", "Refund"];
List subscriptionCustomMonth = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31"
];
List cancelOrder = [
  "Select Reason for Cancellation",
  "I placed a wrong order",
  "I want to add/delete products",
  "I want to change delivery date",
  "I am not available in the selected time slot",
  "Others"
];

List orderRelated = ["Yes", "No"];

Widget customIcons(icon) {
  return Icon(icon, color: Colors.black, size: 20);
}

Widget customBottomImage(image) {
  return Image.asset(image, width: 32);
}

List drawerdata = [
  {
    "title": "Shop",
    "leading":
        FaIcon(getIconFromCss('fat fa-shop'), color: primaryColor, size: 24),
    "trailing": customIcons(Icons.add),
    "child": []
  },
  {
    "title": "Frugivore Originals",
    "leading": FaIcon(getIconFromCss('fat fa-tire-rugged'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/frugivore-originals"
  },
  {
    "title": "Summer Mania Sale",
    "leading": FaIcon(getIconFromCss('fat fa-tire-rugged'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/frugivore-sale"
  },
  {
    "title": "Offers",
    "leading":
        FaIcon(getIconFromCss('fat fa-percent'), color: primaryColor, size: 24),
    "trailing": customIcons(Icons.add),
    "child": [
      // {
      //   "title": "Deals",
      //   "leading": customBottomImage("assets/images/deals.png"),
      //   "action": "/deals"
      // },
      // {
      //   "title": "Promos",
      //   "leading": customBottomImage("assets/images/promos.png"),
      //   "action": "/promos"
      // },
      // {
      //   "title": "Cashback",
      //   "leading": customBottomImage("assets/images/cashback.png"),
      //   "action": "/cashback"
      // },
      {
        "title": "Discount",
        "leading": FaIcon(getIconFromCss('fat fa-badge-percent'),
            color: primaryColor, size: 20),
        "action": "/discount"
      },
      // {
      //   "title": "Signup Up Rewards",
      //   "leading": customBottomImage("assets/images/rewards.png"),
      //   "action": "/sign-up-rewards"
      // }
    ]
  },
  {
    "title": "What's Free",
    "leading":
        FaIcon(getIconFromCss('fat fa-heart'), color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/whats-free"
  },
  {
    "title": "My Orders",
    "leading": FaIcon(getIconFromCss('fat fa-bags-shopping'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/my-order"
  },
  {
    "title": "Notifications",
    "leading":
        FaIcon(getIconFromCss('fat fa-bell'), color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/notification"
  },
  {
    "title": "My Account",
    "leading": FaIcon(getIconFromCss('fat fa-user-vneck-hair'),
        color: primaryColor, size: 24),
    "trailing": customIcons(Icons.add),
    "child": [
      {
        "title": "My Details",
        "leading": FaIcon(getIconFromCss('fat fa-user'),
            color: primaryColor, size: 20),
        "action": "/profile"
      },
      {
        "title": "Edit/Add Address",
        "leading": FaIcon(getIconFromCss('fat fa-address-card'),
            color: primaryColor, size: 20),
        "action": "/address-list"
      },
      {
        "title": "Privacy",
        "leading": FaIcon(getIconFromCss('fat fa-shield-halved'),
            color: primaryColor, size: 20),
        "action": "/privacy"
      },
    ]
  },
  {
    "title": "My Wallet",
    "leading":
        FaIcon(getIconFromCss('fat fa-wallet'), color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/wallet"
  },
  {
    "title": "Help",
    "leading": FaIcon(getIconFromCss('fat fa-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/help-topics"
  },
    {
    "title": "Business Enquiries",
    "leading": FaIcon(getIconFromCss('fat fa-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/business-enquiries"
  },
  // {
  //   "title": "My Subscriptions",
  //   "leading": FaIcon(getIconFromCss('fat fa-calendar-clock'), color: primaryColor, size: 24),
  //   "trailing": null,
  //   "child": [],
  //   "action": "/my-subscription"
  // },
  // {
  //   "title": "My Shopping Lists",
  //   "leading": FaIcon(getIconFromCss('fat fa-clipboard-list-check'), color: primaryColor, size: 24),
  //   "trailing": null,
  //   "child": [],
  //   "action": "/my-shopping-lists"
  // },
  // {
  //   "title": "Recipe Shopping",
  //   "leading": FaIcon(getIconFromCss('fat fa-cauldron'), color: primaryColor, size: 24),
  //   "trailing": null,
  //   "child": [],
  //   "action": "/recipe-tags"
  // },
  {
    "title": "Refer & Earn",
    "leading": FaIcon(getIconFromCss('fat fa-indian-rupee-sign'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/refer-earn"
  },
  {
    "title": "Engage",
    "leading":
        FaIcon(getIconFromCss('fat fa-blog'), color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/blogs"
  },
  {
    "title": "About Us",
    "leading": FaIcon(getIconFromCss('fat fa-memo-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/about-us"
  },
  {
    "title": "Return & Refund Policy",
    "leading": FaIcon(getIconFromCss('fat fa-memo-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/return-refund-policy"
  },
  {
    "title": "Privacy Policy",
    "leading": FaIcon(getIconFromCss('fat fa-memo-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/privacy-policy"
  },
  {
    "title": "Terms & Conditions",
    "leading": FaIcon(getIconFromCss('fat fa-memo-circle-info'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/terms-condition"
  },
  {
    "title": "Logout",
    "leading": FaIcon(getIconFromCss('fat fa-right-from-bracket'),
        color: primaryColor, size: 24),
    "trailing": null,
    "child": [],
    "action": "/logout"
  }
];

void toast(message, {color}) {
  Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
