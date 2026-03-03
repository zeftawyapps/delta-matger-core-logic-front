class EndPoints {
  static const String test = "/system/test-connection";

  // Categories
  static const String categories = "/categories";
  static const String activeCategories = "/categories/active";
  static String orgCategories(String organizationId) =>
      "/categories/organization/$organizationId";
  static String categoryCount(String shopId) =>
      "/categories/shop/$shopId/count";

  // Products
  static const String products = "/products";
  static const String searchProducts = "/products/search";
  static String productById(String productId) => "/products/$productId";
  static String updateStock(String productId) => "/products/$productId/stock";

  // Organizations
  static const String createOrgWithOwner = "/organizations/with-owner";

  // Orders
  static const String orders = "/orders";
  static String orderById(String orderId) => "/orders/$orderId";
  static String shopOrders(String shopId) => "/orders/shop/$shopId";
  static String updateOrderStatus(String orderId) => "/orders/$orderId/status";

  // Auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String profile = "/auth/profile";
}
