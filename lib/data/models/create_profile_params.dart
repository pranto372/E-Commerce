class CreateProfileParams {
  final String cusName;
  final String cusAdd;
  final String cusCity;
  final String cusState;
  final String cusPostCode;
  final String cusCountry;
  final String cusPhone;
  final String cusFax;
  final String shipName;
  final String shipAdd;
  final String shipCity;
  final String shipState;
  final String shipPostCode;
  final String shipCountry;
  final String shipPhone;

  CreateProfileParams(
      this.cusName,
      this.cusAdd,
      this.cusCity,
      this.cusState,
      this.cusPostCode,
      this.cusCountry,
      this.cusPhone,
      this.cusFax,
      this.shipName,
      this.shipAdd,
      this.shipCity,
      this.shipState,
      this.shipPostCode,
      this.shipCountry,
      this.shipPhone);

  Map<String, dynamic> toJson() => {
    "cus_name": cusName,
    "cus_add": cusAdd,
    "cus_city": cusCity,
    "cus_state": cusState,
    "cus_postcode": cusPostCode,
    "cus_country": cusCountry,
    "cus_phone": cusPhone,
    "cus_fax": cusFax,
    "ship_name": shipName,
    "ship_add": shipAdd,
    "ship_city": shipCity,
    "ship_state": shipState,
    "ship_postcode": shipPostCode,
    "ship_country": shipCountry,
    "ship_phone": shipPhone
  };
}
