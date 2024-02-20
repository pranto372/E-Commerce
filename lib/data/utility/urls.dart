class Urls {
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static String sendEmailOtp(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOTP(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryList = '$_baseUrl/CategoryList';
  static String popularProduct = '$_baseUrl/ListProductByRemark/Popular';
  static String specialProduct = '$_baseUrl/ListProductByRemark/Special';
  static String newProduct = '$_baseUrl/ListProductByRemark/New';
  static String productByCategory(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';

  static String productDetails(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static String addToCart = '$_baseUrl/CreateCartList';
  static String cartList = '$_baseUrl/CartList';
  static String createInvoice = '$_baseUrl/InvoiceCreate';
  static String deleteCart(int id) => '$_baseUrl/DeleteCartList/$id';
  static String productWishList = '$_baseUrl/ProductWishList';
  static String createWishList(int id) => '$_baseUrl/CreateWishList/$id';
  static String removeWishList(int id) => '$_baseUrl/RemoveWishList/$id';
  static String reviewList = '$_baseUrl/ListReviewByProduct';
  static String createProductReview = '$_baseUrl/CreateProductReview';
  static String brandList = '$_baseUrl/BrandList';
}