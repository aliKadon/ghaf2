class ApiSettings {
  static const String baseUrl = 'https://api.ghafgate.com/';


  // --- Auth
  static const String register = '${baseUrl}Auth/register';
  static const String login = '${baseUrl}Auth/login';
  // static const String forgotPassword = '${_baseUrl}Auth/forgot-password';
  // static const String resetPassword = '${_baseUrl}Auth/reset-password';
  static const String profile = '${baseUrl}Auth/Auth/getmyinfo';

  // --- Store
  // static const String storeCreateStore = '${_baseUrl}Store/create-Store';
  // static const String StoreGetUserStores = '${_baseUrl}Store/get-user-stores';
  // static const String storeUpdateStorename = '${_baseUrl}Store/update-storename';
  // static const String storeUpdateStorcategory = '${_baseUrl}Store/update-storcategory';

  // --- Category
  static const String category = '${baseUrl}Category/GetCategories';
  static const String getProductById = '${baseUrl}Product/get-product-by-id';
  static const String readProduct = '${baseUrl}Product/read-product';
  static const String addOrRemoveFromFavorite =
      '${baseUrl}Product/add-remove-to-favorite';
  static const String getMyFavorite = '${baseUrl}Product/get-my-favorite';
}
