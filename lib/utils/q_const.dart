class QConst {

  QConst._();

  ///-----[App Strings]-----
  static const String appName = 'Berries Store';
  static const String userName = 'QR Dev Team';
  static const String phoneNumber = '+923346013608';
  static const String userEmail = 'qrdevteam@gmail.com';

  ///-----[Screens Title]-----
  static const String cartScreenTitle = 'Berries Cart';
  static const String checkoutScreenTitle = 'Checkout Cart';
  static const String profileScreenTitle = 'Berries Profile';
  static const String searchHintText = 'Search here...';

  ///-----[Tile Bars]-----
  static const String orderTile = 'My Orders';
  static const String addressTile = 'My Addresses';
  static const String profileTile = 'Profile Settings';

  ///-----[Auth Text Inputs]-----
  static const String signUpText = 'Sign Up';
  static const String signInText = 'Sign In';
  static const String logInText = 'Log In';
  static const String logOutText = 'Logout';

  static const String welcomeText = 'Welcome back!';
  static const String createAccount = 'Create Account!';

  static const String noAccount = 'Don\'t have an account? ';
  static const String alreadyAccount = 'Already have an account? ';

  static const String noUser = 'User not found!';
  static const String errorProfile = 'Error loading User Profile!';

  ///-----[Email Text Inputs]-----
  static const String emailLabel = 'Email Address';
  static const String emailText = 'Enter Email';
  static const String emailText1 = 'Please enter your email';
  static const String emailText2 = 'Please enter a valid email address';

  ///-----[Password Text Inputs]-----
  static const String passLabel = 'Password';
  static const String passText = 'Enter Password';
  static const String passText1 = 'Please enter your password';
  static const String passText6 = 'Password must be at least 6 characters long';

  static const String passForgot = 'Forgot Password?';
  static const String passNoMatch = 'Passwords do not match';
  static const String passConfirm = 'Confirm Password';
  static const String passConfirm1 = 'Please Enter Confirm Password';

  ///-----[First Name Text Inputs]-----
  static const String firstNameLabel = 'First Name';
  static const String firstNameText = 'Enter First Name';
  static const String firstNameText1 = 'Please enter your First Name';

  ///-----[Last Name Text Inputs]-----
  static const String lastNameLabel = 'Last Name';
  static const String lastNameText = 'Enter Last Name';
  static const String lastNameText1 = 'Please enter your Last Name';

  ///-----[User Name Text Inputs]-----
  static const String userNameLabel = 'User Name';
  static const String userNameText = 'Enter User Name';
  static const String userNameText1 = 'Please enter your User Name';

  ///-----[Phone Number Text Inputs]-----
  static const String phoneLabel = 'Phone Number';
  static const String phoneText = 'Enter Phone Number';
  static const String phoneText1 = 'Please enter your Phone Number';

  static const String privacyAgree = 'By signing up you agree to the ';
  static const String privacyTerms = 'Terms of Service and Privacy Policy';

  ///-----[Social Icons Text Labels]-----
  static const String googleLabel = 'Google';
  static const String facebookLabel = 'Facebook';

  ///-----[Store Texts Labels]-----
  static const String categoriesText = 'Categories';
  static const String productsText = 'Featured Products';

  ///-----[Cart Texts Labels]-----
  static const String currency = 'SEK';
  static const String cartKey = 'cart_items';
  static const String checkout = 'CHECK-OUT';
  static const String continueText = 'Continue';
  static const String addToCart = 'Add To Cart';
  static const String productAddCart = 'Product Added To Cart';

  static const String noCartItem = 'No Item Found in Cart.';
  static const String merchantDisplayName = 'Berries-Store';
  static const String payWithStripe = 'PAY WITH STRIPE';
  static const String paymentSuccess = 'Payment Successful!';
  static const String itemShipped = 'Your item will be shipped soon!';

  ///-----[Order Text Labels]-----
  static const String subTotal = 'Sub Total';
  static const String shipFee = 'Shipping Fee';
  static const String orderTotal = 'Order Total';
  static const String totalAmount = 'Total Amount';

  ///-----[Notification Text Labels]-----
  static const String orderChannelID = 'order_success_channel';
  static const String orderChannelName = 'Order Notification';

  ///-----[General Text Labels]-----
  static const String reviewText = 'Reviews';
  static const String seeMoreText = 'See More...';
  static const String seeLessText = 'See Less.';

  static const String addressText = 'Address';
  static const String stockAvail = 'Stock Available';
  static const String successAdd = 'Successfully Added';
  static const String requiredField = '* Required Field';
  static const String sendNotification = 'Send Notification !';

  ///-----[App Lists]-----

  // static List<BannerModel> banners = [
  //
  //   BannerModel(id: 1, photo: QImages.eb1),
  //   BannerModel(id: 2, photo: QImages.eb2),
  //   BannerModel(id: 3, photo: QImages.eb3),
  //   BannerModel(id: 4, photo: QImages.eb4),
  //
  //   BannerModel(id: 5, photo: QImages.banner1),
  //   BannerModel(id: 6, photo: QImages.banner2),
  //   BannerModel(id: 7, photo: QImages.banner3),
  //   BannerModel(id: 8, photo: QImages.banner4),
  //   BannerModel(id: 9, photo: QImages.banner5),
  //   BannerModel(id: 10, photo: QImages.banner6),
  // ];

  ///-----[Firestore Collections]-----
  static const String userCollection = 'users';

  /// E-Com App Collections
  static const String categoryCollection = 'categories';
  static const String productCollection = 'products';
  static const String cartCollection = 'cart';
  static const String orderCollection = 'orders';

  /// Admin Panel App Collections
  static const String driversCollection = 'drivers';
  static const String onlineDriversCollection = 'onlineDrivers';
  static const String tripRequestsCollection = 'tripRequests';

}