class CreatePaymentLink {
  String id;
  String object;
  bool active;
  Map<String, dynamic> afterCompletion;
  bool allowPromotionCodes;
  String applicationFeeAmount;
  String applicationFeePercent;
  Map<String, dynamic> automaticTax;
  String billingAddressCollection;
  String consentCollection;
  String currency;
  Map<String, dynamic> customText;
  String customerCreation;
  String lineItems;
  bool livemode;
  Map<String, dynamic> metadata;
  String onBehalfOfId;
  String onBehalfOf;
  String paymentIntentData;
  String paymentMethodCollection;
  String paymentMethodTypes;
  Map<String, dynamic> phoneNumberCollection;
  String shippingAddressCollection;
  List<dynamic> shippingOptions;
  String submitType;
  String subscriptionData;
  Map<String, dynamic> taxIdCollection;
  String transferData;
  String url;
  Map<String, dynamic> rawJObject;
  Map<String, dynamic> stripeResponse;

  CreatePaymentLink(
    this.id,
    this.object,
    this.active,
    this.afterCompletion,
    this.allowPromotionCodes,
    this.applicationFeeAmount,
    this.applicationFeePercent,
    this.automaticTax,
    this.billingAddressCollection,
    this.consentCollection,
    this.currency,
    this.customText,
    this.customerCreation,
    this.lineItems,
    this.livemode,
    this.metadata,
    this.onBehalfOfId,
    this.onBehalfOf,
    this.paymentIntentData,
    this.paymentMethodCollection,
    this.paymentMethodTypes,
    this.phoneNumberCollection,
    this.shippingOptions,
    this.shippingAddressCollection,
    this.submitType,
    this.subscriptionData,
    this.taxIdCollection,
    this.transferData,
    this.url,
    this.rawJObject,
    this.stripeResponse,
  );
}
