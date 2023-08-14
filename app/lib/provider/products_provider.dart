import 'package:flutter/material.dart';
import '../models/products_model.dart';
import '../resources/strings_manager.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isProductOnSale).toList();
  }

  ProductModel findProductById(String productId) {
    return _productsList
        .firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    return _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
  }

  static final List<ProductModel> _productsList = [
    ProductModel(
      "1234",
      "Samsung smart TV",
      "https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0",
      AppStrings.audioVideo,
      12000.0,
      11000.0,
      true,
    ),
    ProductModel(
      "1233",
      "Asus Laptop",
      "https://th.bing.com/th/id/R.477b03591bd4298ae85d094b183eb071?rik=ZepPiKJ%2bATaFug&pid=ImgRaw&r=0",
      AppStrings.audioVideo,
      20000.0,
      19500.0,
      true,
    ),
    ProductModel(
      "2345",
      "Sony Headphones",
      "https://th.bing.com/th/id/R.ec47b1f0ecda038d0cc4adb0d2c3fccc?rik=sOkyfwTnwlahtQ&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f6%2fSony-Headphone-PNG-Transparent-HD-Photo.png&ehk=Vu7ZbpneQhr2vkK2hYLidRoGRHa0uBob6%2fTavDJBx1A%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.audioVideo,
      5550.0,
      4500.0,
      false,
    ),
    ProductModel(
      "2346",
      "Apple AirPods",
      "https://th.bing.com/th/id/R.b354139a1780ff93cd4852072631bf90?rik=JnlV2BUqtuumWw&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f13%2fApple-Airpods-PNG-Photos.png&ehk=syVSlByzt608VsrAKSVHbWiUmkViy7JwkqxkDnTbRqM%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.audioVideo,
      5600.0,
      5280.0,
      true,
    ),
    ProductModel(
      "2347",
      "Nintendo Switch",
      "https://www.vhv.rs/file/max/10/109868_nintendo-switch-transparent-png.png", // Transparent image URL
      AppStrings.gaming,
      4450.0,
      4420.0,
      true,
    ),
    ProductModel(
        "2348",
        "Dell Monitor",
        "https://th.bing.com/th/id/R.682f3ea5389cd38474dd95ce6383ea46?rik=hlRklDh%2fpTUqFQ&pid=ImgRaw&r=0", // Transparent image URL
        AppStrings.officeElectronics,
        6600.0,
        5450.0,
        false),
    ProductModel(
        "2349",
        "Amazon Echo Dot",
        "https://www.pngarts.com/files/8/Alexa-Amazon-Echo-Transparent-Image.png", // Transparent image URL
        AppStrings.consumerElectronics,
        950.0,
        875.0,
        false),
    ProductModel(
      "2350",
      "Samsung Microwave",
      "https://th.bing.com/th/id/R.86bb61e598df8b99e7ebed4aa9b452d4?rik=40e7tGPVE6CFkw&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.homeAppliances,
      9150.0,
      9000.0,
      true,
    ),
    ProductModel(
        "2351",
        "Sony PlayStation 5",
        "https://th.bing.com/th/id/R.f68e156b0b7e6cf88287244a3d145f5a?rik=mQJZxb8Oy6lpWQ&pid=ImgRaw&r=0", // Transparent image URL
        AppStrings.gaming,
        10600.0,
        10500.0,
        false),
    ProductModel(
      "2352",
      "HP Printer",
      "https://th.bing.com/th/id/R.6ca8832300029f0a5580e4ef2bd733fe?rik=Uun44%2bnQPO5kQw&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f7%2fLaserjet-Printer-Transparent-Background.png&ehk=9XHGxaQnIy1hRIYVe13cPz9MhHxWjPbGDv%2fgfW5aTlQ%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.officeElectronics,
      7150.0,
      7100.0,
      true,
    ),
    ProductModel(
      "2353",
      "LG Refrigerator",
      "https://th.bing.com/th/id/R.fc1ba3f7356672e548423f179dd3702a?rik=s8cCKYhNStb%2btw&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f6%2fLG-Refrigerator-Transparent-PNG.png&ehk=dLol2UrhsrT1lwdej7Cug4WTd53XyP%2f%2f8gRZ%2bktvb8c%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.homeAppliances,
      5900.0,
      5800.0,
      true,
    ),
    ProductModel(
      "2354",
      "Sony Camera",
      "https://th.bing.com/th/id/R.cdb6f7240e68c9760caa3b0a45769983?rik=aAHV7Bjk1yHw7g&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fcamera-png-transparent%2fcamera-png-transparent-15.png&ehk=TDkqSbGoJN%2bxzHQH0qUsqlxTXWoSD8L3SzWJ%2bgoMT%2b8%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.consumerElectronics,
      6400.0,
      6340.0,
      true,
    ),
    ProductModel(
        "2355",
        "Bose Speakers",
        "https://th.bing.com/th/id/R.a2ed2a151c9ba6b4bc6052a22c717a92?rik=VHZMDy73KWZCmg&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f7%2fBlack-Bluetooth-Speaker-Transparent-PNG.png&ehk=g3q5wl6%2f%2bFA8NLPyf3q45%2frzzHuIjaRpFw7tOyPL2Hs%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
        AppStrings.audioVideo,
        2250.0,
        2230.0,
        false),
    ProductModel(
      "2356",
      "Apple iPad",
      "https://th.bing.com/th/id/R.e1742d08ea20dc1f58b73bf3f89aab4e?rik=j04mBIWt0vHiTQ&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f4%2fiPad-PNG-HD.png&ehk=JWlPykj2B%2frXHZ%2f19GrErjr3EZIsr0444zi8YHY7XDo%3d&risl=&pid=ImgRaw&r=0", // Transparent image URL
      AppStrings.consumerElectronics,
      4700.0,
      4600.0,
      true,
    ),
    ProductModel(
        "2357",
        "Dyson Vacuum Cleaner",
        "https://th.bing.com/th/id/R.013b5e342a27a3742bb307ef08585488?rik=jIDLqv%2bLMAa1tg&pid=ImgRaw&r=0", // Transparent image URL
        AppStrings.homeAppliances,
        4300.0,
        4230.0,
        false),
  ];
}