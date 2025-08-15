import 'package:get/route_manager.dart';
// import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:frugivore/error.dart';
import 'package:frugivore/screens/home.dart';
import 'package:frugivore/screens/login.dart';
import 'package:frugivore/screens/auth.dart';
import 'package:frugivore/screens/welcome.dart';
import 'package:frugivore/screens/whatsFree.dart';
import 'package:frugivore/screens/product_search.dart';
import 'package:frugivore/screens/profile/profile.dart';
import 'package:frugivore/screens/cart.dart';
import 'package:frugivore/screens/vendor.dart';
import 'package:frugivore/screens/childOrder/cart.dart';


import 'package:frugivore/screens/preOrder/preOrder.dart';
import 'package:frugivore/screens/preOrder/preOrderCart.dart';
import 'package:frugivore/screens/order_review.dart';
import 'package:frugivore/screens/childOrder/orderReview.dart';
import 'package:frugivore/screens/preOrder/orderReview.dart';

import 'package:frugivore/screens/payment.dart';
import 'package:frugivore/screens/successfull.dart';
import 'package:frugivore/screens/order_tracking.dart';
import 'package:frugivore/screens/subcategory.dart';
import 'package:frugivore/screens/categories.dart';
import 'package:frugivore/screens/product_detail.dart';
import 'package:frugivore/screens/frugivore_originals.dart';
import 'package:frugivore/screens/frugivore_sale.dart';
import 'package:frugivore/screens/order/myOrder.dart';
import 'package:frugivore/screens/order/orderDetail.dart';

import 'package:frugivore/screens/purchase_items.dart';
import 'package:frugivore/screens/shopping_list/myShoppingLists.dart';
import 'package:frugivore/screens/shopping_list/shoppingListDetail.dart';
import 'package:frugivore/screens/shopping_list/edit_shopping_list_detail.dart';
import 'package:frugivore/screens/subscription/mySubscription.dart';
import 'package:frugivore/screens/subscription/subscriptionDetail.dart';
import 'package:frugivore/screens/subscription/editSubscriptionPlan.dart';
import 'package:frugivore/screens/subscription/createSubscriptionPlan.dart';
import 'package:frugivore/screens/wallet/wallet.dart';
import 'package:frugivore/screens/wallet/addMoney.dart';
import 'package:frugivore/screens/wallet/transactionHistory.dart';

import 'package:frugivore/screens/help/helpDetail.dart';
import 'package:frugivore/screens/help/topics.dart';
import 'package:frugivore/screens/help/subTopics.dart';
import 'package:frugivore/screens/help/subsubTopics.dart';
import 'package:frugivore/screens/help/subTopicDetail.dart';
import 'package:frugivore/screens/help/archives.dart';
import 'package:frugivore/screens/help/helps.dart';

import 'package:frugivore/screens/business_enquiries.dart';


import 'package:frugivore/screens/notification.dart';
import 'package:frugivore/screens/address/addressList.dart';
import 'package:frugivore/screens/address/add_address.dart';
import 'package:frugivore/screens/address/editAddress.dart';
import 'package:frugivore/screens/profile/changeEmail.dart';
import 'package:frugivore/screens/profile/privacy.dart';
import 'package:frugivore/screens/orderOtp.dart';
import 'package:frugivore/screens/offers/deals.dart';
import 'package:frugivore/screens/offers/promos.dart';
import 'package:frugivore/screens/offers/cashback.dart';
import 'package:frugivore/screens/offers/discounts.dart';
import 'package:frugivore/screens/static_pages/get_help.dart';
import 'package:frugivore/screens/static_pages/sign_up_rewards.dart';
import 'package:frugivore/screens/static_pages/refer_and_earn.dart';
import 'package:frugivore/screens/static_pages/contact_us.dart';
import 'package:frugivore/screens/static_pages/blogs.dart';
import 'package:frugivore/screens/static_pages/about_us.dart';
import 'package:frugivore/screens/static_pages/return_refund.dart';
import 'package:frugivore/screens/static_pages/privacy_policy.dart';
import 'package:frugivore/screens/static_pages/terms_condition.dart';
import 'package:frugivore/screens/static_pages/faq.dart';
import 'package:frugivore/screens/recipe/recipes_tag.dart';
import 'package:frugivore/screens/recipe/recipes.dart';
import 'package:frugivore/screens/recipe/recipe_detail.dart';
import 'package:frugivore/screens/recipe/recipe_shopping.dart';

GetStorage box = GetStorage();
List<GetPage> routes() => [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/auth/:mobile/:uuid', page: () => AuthPage()),
      GetPage(name: '/get-help', page: () => GetHelpPage()),
      
      GetPage(name: '/', page: () => HomePage()),
      GetPage(
          name: '/REFERRAL/:referrerCode',
          page: () {
            return !box.hasData('token') ? LoginPage() : LoginPage();
          }),
      GetPage(
          name: '/REFERRAL/:referrerCode/:referredCode',
          page: () {
            return !box.hasData('token') ? LoginPage() : LoginPage();
          }),
      GetPage(
          name: '/search',
          page: () {
            return !box.hasData('token') ? LoginPage() : ProductSearchPage();
          }),
      GetPage(
          name: '/cart',
          page: () {
            return !box.hasData('token') ? LoginPage() : CartPage();
          }),
      GetPage(
          name: '/vendors',
          page: () {
            return !box.hasData('token') ? LoginPage() : VendorPage();
          }),
      GetPage(
          name: '/child-cart/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : ChildCartPage();
          }),
      GetPage(
          name: '/frugivore-originals',
          page: () {
            return FrugivoreOriginalsPage();
          }),
      GetPage(
          name: '/frugivore-sale/:slug',
          page: () {
            return !box.hasData('token') ? LoginPage() : FrugivoreSalePage();
          }),
      GetPage(
          name: '/whats-free',
          page: () {
            return !box.hasData('token') ? LoginPage() : WhatsFreePage();
          }),
      GetPage(
          name: '/pre-order',
          page: () {
            return !box.hasData('token') ? LoginPage() : PreOrderPage();
          }),
      GetPage(
          name: '/pre-order-cart',
          page: () {
            return !box.hasData('token') ? LoginPage() : PreOrderCartPage();
          }),
      GetPage(
          name: '/subcategory/:category/:subcategory',
          page: () {
            return SubCategoryPage();
          }),
      GetPage(
          name: '/shop-by-categories',
          page: () {
            return CategoriesPage();
          }),
      GetPage(
          name: '/recipe-tags',
          page: () {
            return RecipesTagPage();
          }),
      GetPage(
          name: '/recipes/:name',
          page: () {
            return RecipesPage();
          }),
      GetPage(
          name: '/recipe-detail/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : RecipeDetailPage();
          }),
      GetPage(
          name: '/recipe-shopping/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : RecipeShoppingPage();
          }),
      GetPage(
          name: '/product-details/:slug',
          page: () {
            return !box.hasData('token') ? LoginPage() : ProductDetailPage();
          }),
      GetPage(
          name: '/sign-up-rewards',
          page: () {
            return !box.hasData('token') ? LoginPage() : SignUpRewardsPage();
          }),
      GetPage(
          name: '/deals',
          page: () {
            return !box.hasData('token') ? LoginPage() : DealsPage();
          }),
      GetPage(
          name: '/promos',
          page: () {
            return !box.hasData('token') ? LoginPage() : PromosPage();
          }),
      GetPage(
          name: '/cashback',
          page: () {
            return !box.hasData('token') ? LoginPage() : CashbackPage();
          }),
      GetPage(
          name: '/discount',
          page: () {
            return !box.hasData('token') ? LoginPage() : DiscountsPage();
          }),
      GetPage(
          name: '/contactus',
          page: () {
            return ContactUsPage();
          }),
      GetPage(
          name: '/blogs/:name',
          page: () {
            return BlogsPage();
          }),
      GetPage(
          name: '/about-us',
          page: () {
            return AboutUsPage();
          }),
      GetPage(
          name: '/return-refund-policy',
          page: () {
            return ReturnRefundPage();
          }),
      GetPage(
          name: '/privacy-policy',
          page: () {
            return PrivacyPolicyPage();
          }),
      GetPage(
          name: '/terms-condition',
          page: () {
            return TermsConditionPage();
          }),
      GetPage(
          name: '/faq',
          page: () {
            return FAQPage();
          }),
      GetPage(
          name: '/refer-earn',
          page: () {
            return !box.hasData('token') ? LoginPage() : ReferEarnPage();
          }),
      GetPage(
          name: '/welcome',
          page: () {
            return WelcomePage();
          }),
      GetPage(
          name: '/purchase-items',
          page: () {
            return !box.hasData('token') ? LoginPage() : PurchaseItemsPage();
          }),
      GetPage(
          name: '/profile',
          page: () {
            return !box.hasData('token') ? LoginPage() : ProfilePage();
          }),
      GetPage(
          name: '/change-email',
          page: () {
            return !box.hasData('token') ? LoginPage() : ChangeEmailPage();
          }),
      GetPage(
          name: '/address-list',
          page: () {
            return !box.hasData('token') ? LoginPage() : AddressListPage();
          }),
      GetPage(
          name: '/add-address',
          page: () {
            return !box.hasData('token') ? LoginPage() : AddAddressPage();
          }),
      GetPage(
          name: '/edit-address/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : EditAddressPage();
          }),
      GetPage(
          name: '/privacy',
          page: () {
            return !box.hasData('token') ? LoginPage() : PrivacyPage();
          }),
      GetPage(
          name: '/my-order',
          page: () {
            return !box.hasData('token') ? LoginPage() : MyOrderPage();
          }),
      GetPage(
          name: '/order-detail/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : OrderDetailPage();
          }),
      GetPage(
          name: '/my-shopping-lists',
          page: () {
            return !box.hasData('token') ? LoginPage() : MyShoppingListsPage();
          }),
      GetPage(
          name: '/shopping-list-detail/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : ShoppingListDetailPage();
          }),
      GetPage(
          name: '/edit-shopping-list/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : EditShoppingListDetailPage();
          }),
      GetPage(
          name: '/my-subscription',
          page: () {
            return !box.hasData('token') ? LoginPage() : MySubscriptionPage();
          }),
      GetPage(
          name: '/subscribe-shopping-list/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : CreateSubscriptionPlanPage();
          }),
      GetPage(
          name: '/subscription-detail/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : SubscriptionDetailPage();
          }),
      GetPage(
          name: '/edit-subscription-plan/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : EditSubscriptionPlanPage();
          }),
      GetPage(
          name: '/wallet',
          page: () {
            return !box.hasData('token') ? LoginPage() : WalletPage();
          }),
      GetPage(
          name: '/recharge/:money',
          page: () {
            return !box.hasData('token') ? LoginPage() : AddMoneyPage();
          }),
      GetPage(
          name: '/wallet-history?:qsp',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : TransactionHistoryPage();
          }),
      GetPage(
          name: '/help-topics',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpTopicsPage();
          }),
      GetPage(
          name: '/business-enquiries',
          page: () {
            return !box.hasData('token') ? LoginPage() : BusinessEnquiriesPage();
          }),
      GetPage(
          name: '/help-subtopics/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpSubTopicsPage();
          }),
      GetPage(
          name: '/help-sub-subtopics/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpSubSubTopicsPage();
          }),
      GetPage(
          name: '/help-subtopic-detail/:uuid',
          page: () {
            return !box.hasData('token')
                ? LoginPage()
                : HelpSubTopicDetailPage();
          }),
      GetPage(
          name: '/archives',
          page: () {
            return !box.hasData('token') ? LoginPage() : ArchivesPage();
          }),
      GetPage(
          name: '/helps',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpsPage();
          }),
      GetPage(
          name: '/help-detail/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpDetailPage();
          }),
      GetPage(
          name: '/complaint-detail/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : HelpDetailPage();
          }),
      GetPage(
          name: '/notification',
          page: () {
            return !box.hasData('token') ? LoginPage() : NotificationsPage();
          }),
      GetPage(
          name: '/order-review',
          page: () {
            return !box.hasData('token') ? LoginPage() : OrderReviewPage();
          }),
      GetPage(
          name: '/child-order-review/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : ChildOrderReviewPage();
          }),
      GetPage(
          name: '/pre-order-review',
          page: () {
            return !box.hasData('token') ? LoginPage() : PreOrderReviewPage();
          }),
      GetPage(
          name: '/payment/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : PaymentPage();
          }),
      GetPage(
          name: '/order-otp/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : OrderOtppage();
          }),
      GetPage(
          name: '/successfull/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : SuccessfullPage();
          }),
      GetPage(
          name: '/order-tracking/:uuid',
          page: () {
            return !box.hasData('token') ? LoginPage() : OrderTrackingPage();
          }),
    ];

// const String LoginRoute = '/login';
// const String AuthRoute = '/auth';

// const String HomeRoute = '/';

// const String ReferralRoute = '/REFERRAL/:referrerCode';
// const String ReferrerRoute = '/REFERRAL/:referrerCode/:referredCode';
// const String SearchRoute = '/search';
// const String CartRoute = '/cart';
// const String VendorRoute = '/vendors';
// const String ChildCartRoute = '/child-cart/:uuid';
// const String PreOrderrRoute = '/pre-order';
// const String PreOrderCartRoute = '/pre-order-cart';
// const String SubcategoryRoute = '/subcategory/:category/:subcategory';
// const String ShopByCategoriesRoute = '/shop-by-categories';
// const String RecipeTagsRoute = '/recipe-tags';
// const String RecipeNameRoute = '/recipes/:name';
// const String RecipeDetaillRoute = '/recipe-detail/:uuid';
// const String RecipeShoppingRoute = '/recipe-shopping/:uuid';
// const String ProductDetailRoute = '/product-details/:slug';
// const String SignupRewardRoute = '/sign-up-rewards';
// const String DealsRoute = '/deals';
// const String PromosRoute = '/promos';
// const String CashbackRoute = '/cashback';
// const String DiscountRoute = '/discount';
// const String ContactUsRoute = '/contactus';
// const String BlogsNameRoute = '/blogs/:name';
// const String AboutUsRoute = '/about-us';
// const String ReturnRefundPolicyRoute = '/return-refund-policy';
// const String PrivacyRoute = '/privacy-policy';
// const String TermsConditionsRoute = '/terms-condition';
// const String FaqRoute = '/faq';
// const String ReferEarnRoute = '/refer-earn';
// const String WelcomeRoute = '/welcome';
// const String PurchaseItemsRoute = '/purchase-items';
// const String ProfileRoute = '/profile';
// const String ChangeEmailRoute = '/change-email';
// const String AddressListRoute = '/address-list';
// const String AddAddressRoute = '/add-address';
// const String EditAddressRoute = '/edit-address/:uuid';
// const String MyOrderRoute = '/my-order';
// const String OrderDetailRoute = '/order-detail/:uuid';
// const String MyShoppingListRoute = '/my-shopping-lists';
// const String ShoppingListDetailRoute = '/shopping-list-detail/:uuid';
// const String EditShooppingListRoute = '/edit-shopping-list/:uuid';
// const String MySubscriptionRoute = '/my-subscription';
// const String SubscribeShoppingListRoute = '/subscribe-shopping-list/:uuid';
// const String SubscriptionDetailRoute = '/subscription-detail/:uuid';
// const String EditSubscriptionPlanRoute = '/edit-subscription-plan/:uuid';
// const String WalletRoute = '/wallet';
// const String AddMoneyRoute = '/recharge/:money';
// const String WalletHistoryRoute = '/wallet-history?:qsp';

// const String HelpTopicsRoute = '/help-topics';
// const String HelpSubTopicsRoute = '/help-subtopics/:uuid';
// const String HelpSubSubTopicsRoute = '/help-sub-subtopics/:uuid';
// const String HelpSubTopicDetailRoute = '/help-subtopic-detail/:uuid';
// const String ArchivesRoute = '/archives';
// const String HelpsRoute = '/helps';
// const String HelpDetailRoute = '/help-detail/:uuid';
// const String ComplaintDetailRoute = '/complaint-detail/:uuid';

// const String NotificationRoute = '/notification';
// const String OrderReviewRoute = '/order-review';
// const String ChildOrderReviewRoute = '/child-order-review/:uuid';
// const String PreOrderReviewRoute = '/pre-order-review';
// const String PaymentRoute = '/payment/:uuid';
// const String OrderOtpRoute = '/order-otp/:uuid';
// const String SuccessfullRoute = '/successfull/:uuid';

