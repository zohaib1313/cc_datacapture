class ProductModel {
  Meta? meta;
  Data? data;

  ProductModel({this.meta, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Meta {
  int? statusCode;
  String? message;

  Meta({this.statusCode, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  ItemDetails? itemDetails;
  OrderDetails? orderDetails;
  Trends? trends;
  List<String>? barcodes;
  List<String>? gimabarcode;

  Data(
      {this.itemDetails,
      this.orderDetails,
      this.trends,
      this.barcodes,
      this.gimabarcode});

  Data.fromJson(Map<String, dynamic> json) {
    itemDetails = json['itemDetails'] != null
        ? new ItemDetails.fromJson(json['itemDetails'])
        : null;
    orderDetails = json['orderDetails'] != null
        ? new OrderDetails.fromJson(json['orderDetails'])
        : null;
    trends =
        json['trends'] != null ? new Trends.fromJson(json['trends']) : null;
    barcodes = json['barcodes'].cast<String>();
    gimabarcode = json['gimabarcode'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemDetails != null) {
      data['itemDetails'] = this.itemDetails!.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.toJson();
    }
    if (this.trends != null) {
      data['trends'] = this.trends!.toJson();
    }
    data['barcodes'] = this.barcodes;
    data['gimabarcode'] = this.gimabarcode;
    return data;
  }
}

class ItemDetails {
  String? itemCode;
  String? itemDesc;
  String? posPrice;
  String? currencyType;
  String? itemStatus;
  String? itemDept;
  String? itemSection;
  String? itemFamily;
  String? itemSubFamily;
  String? storeCode;
  String? assortment;
  String? facing;
  ShelfLocation? shelfLocation;
  String? published;
  String? expressOrderStatus;
  String? bandA;
  String? pCB;

  ItemDetails(
      {this.itemCode,
      this.itemDesc,
      this.posPrice,
      this.currencyType,
      this.itemStatus,
      this.itemDept,
      this.itemSection,
      this.itemFamily,
      this.itemSubFamily,
      this.storeCode,
      this.assortment,
      this.facing,
      this.shelfLocation,
      this.published,
      this.expressOrderStatus,
      this.bandA,
      this.pCB});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemDesc = json['item_desc'];
    posPrice = json['pos_price'];
    currencyType = json['currency_type'];
    itemStatus = json['item_status'];
    itemDept = json['item_dept'];
    itemSection = json['item_section'];
    itemFamily = json['item_family'];
    itemSubFamily = json['item_sub_family'];
    storeCode = json['store_code'];
    assortment = json['assortment'];
    facing = json['facing'];
    shelfLocation = json['shelfLocation'] != null
        ? new ShelfLocation.fromJson(json['shelfLocation'])
        : null;
    published = json['published'];
    expressOrderStatus = json['express_order_status'];
    bandA = json['bandA'];
    pCB = json['PCB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_desc'] = this.itemDesc;
    data['pos_price'] = this.posPrice;
    data['currency_type'] = this.currencyType;
    data['item_status'] = this.itemStatus;
    data['item_dept'] = this.itemDept;
    data['item_section'] = this.itemSection;
    data['item_family'] = this.itemFamily;
    data['item_sub_family'] = this.itemSubFamily;
    data['store_code'] = this.storeCode;
    data['assortment'] = this.assortment;
    data['facing'] = this.facing;
    if (this.shelfLocation != null) {
      data['shelfLocation'] = this.shelfLocation!.toJson();
    }
    data['published'] = this.published;
    data['express_order_status'] = this.expressOrderStatus;
    data['bandA'] = this.bandA;
    data['PCB'] = this.pCB;
    return data;
  }
}

class ShelfLocation {
  String? location;
  String? aisle;
  String? position;
  String? element;
  String? shelfNumber;

  ShelfLocation(
      {this.location,
      this.aisle,
      this.position,
      this.element,
      this.shelfNumber});

  ShelfLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    aisle = json['aisle'];
    position = json['position'];
    element = json['element'];
    shelfNumber = json['shelfNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['aisle'] = this.aisle;
    data['position'] = this.position;
    data['element'] = this.element;
    data['shelfNumber'] = this.shelfNumber;
    return data;
  }
}

class OrderDetails {
  String? physicalQuantity;
  String? nextOrderDate;
  String? orderedQuantity;
  String? nextDeliveryDate;
  String? supplierName;
  String? supplierId;
  String? supplierStatus;
  String? currentStock;
  String? minStock;

  OrderDetails(
      {this.physicalQuantity,
      this.nextOrderDate,
      this.orderedQuantity,
      this.nextDeliveryDate,
      this.supplierName,
      this.supplierId,
      this.supplierStatus,
      this.currentStock,
      this.minStock});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    physicalQuantity = json['physical_quantity'];
    nextOrderDate = json['next_order_date'];
    orderedQuantity = json['ordered_quantity'];
    nextDeliveryDate = json['next_delivery_date'];
    supplierName = json['supplier_name'];
    supplierId = json['supplier_id'];
    supplierStatus = json['supplier_status'];
    currentStock = json['current_stock'];
    minStock = json['min_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['physical_quantity'] = this.physicalQuantity;
    data['next_order_date'] = this.nextOrderDate;
    data['ordered_quantity'] = this.orderedQuantity;
    data['next_delivery_date'] = this.nextDeliveryDate;
    data['supplier_name'] = this.supplierName;
    data['supplier_id'] = this.supplierId;
    data['supplier_status'] = this.supplierStatus;
    data['current_stock'] = this.currentStock;
    data['min_stock'] = this.minStock;
    return data;
  }
}

class Trends {
  SalesHistory? salesHistory;
  SalesHistory? adjust;
  SalesHistory? stockEnd;

  Trends({this.salesHistory, this.adjust, this.stockEnd});

  Trends.fromJson(Map<String, dynamic> json) {
    salesHistory = json['salesHistory'] != null
        ? new SalesHistory.fromJson(json['salesHistory'])
        : null;
    adjust = json['adjust'] != null
        ? new SalesHistory.fromJson(json['adjust'])
        : null;
    stockEnd = json['stockEnd'] != null
        ? new SalesHistory.fromJson(json['stockEnd'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salesHistory != null) {
      data['salesHistory'] = this.salesHistory!.toJson();
    }
    if (this.adjust != null) {
      data['adjust'] = this.adjust!.toJson();
    }
    if (this.stockEnd != null) {
      data['stockEnd'] = this.stockEnd!.toJson();
    }
    return data;
  }
}

class SalesHistory {
  String? d1;
  String? d2;
  String? d3;
  String? d4;
  String? d5;
  String? d6;
  String? d7;

  SalesHistory({this.d1, this.d2, this.d3, this.d4, this.d5, this.d6, this.d7});

  SalesHistory.fromJson(Map<String, dynamic> json) {
    d1 = json['D-1'];
    d2 = json['D-2'];
    d3 = json['D-3'];
    d4 = json['D-4'];
    d5 = json['D-5'];
    d6 = json['D-6'];
    d7 = json['D-7'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['D-1'] = this.d1;
    data['D-2'] = this.d2;
    data['D-3'] = this.d3;
    data['D-4'] = this.d4;
    data['D-5'] = this.d5;
    data['D-6'] = this.d6;
    data['D-7'] = this.d7;
    return data;
  }
}
