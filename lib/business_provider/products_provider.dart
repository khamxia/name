import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/screen/model/branch_model.dart';
import 'package:meesooklife_app/screen/model/category_model.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:meesooklife_app/screen/model/products_model.dart';
import 'package:meesooklife_app/screen/products/models/cart_model.dart';
import 'package:meesooklife_app/services/get_branch.dart';
import 'package:meesooklife_app/services/get_top_ten_products.dart';
import 'package:meesooklife_app/services/post_product_by_branch.dart';
import '../screen/model/products_by_branch_model.dart';
import '../services/get_category.dart';
import '../services/get_products.dart';
import '../utilities/login_sharepref.dart';

class ProductsProvider extends ChangeNotifier {
  CategoryModel? _categoryModel;
  List<Category> _category = [];
  ProductsModel? _productsModel;
  List<Product> _products = [];
  ProductsModel? _topTenProductModel;
  List<Product> _topTenProduct = [];
  BranchModel? _branchModel;
  List<TopBranch> _branch = [];
  ProductByBranchModel? _productbybranch;
  List<BProduct>? _productbybranchlist;

  List<CartModel> _cartmodel = [];
  int _branchId = 0;
  ///////////////
  int _prAmount = 0;
  double _total = 0.0;
  int _amount = 0;

  int get getPrAmount => _prAmount;
  double get getTotal => _total;
  int get getAmount => _amount;

  set setPrAmount(int pramount) {
    _prAmount = pramount;
    notifyListeners();
  }

  set setTotal(double total) {
    _total = total;
    notifyListeners();
  }

  set setAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  ///////////////
  CategoryModel? get getCategoryModel => _categoryModel;
  List<Category> get getCategory => _category;
  ProductsModel? get getProductsModel => _productsModel;
  List<Product> get getProducts => _products;
  ProductsModel? get getTopTenProductModel => _topTenProductModel;
  List<Product> get getTopTenProduct => _topTenProduct;
  BranchModel? get getBranchModel => _branchModel;
  List<TopBranch> get gettopBranch => _branch;
  ProductByBranchModel? get getProductbybranch => _productbybranch;
  List<BProduct>? get getProductbybranchlist => _productbybranchlist;
  int get getBranchId => _branchId;

  set setBranchId(int branchid) {
    _branchId = branchid;
    notifyListeners();
  }

  List<CartModel> get getCartModel => _cartmodel;
  set setCartModel(List<CartModel> cartmodel) {
    _cartmodel = cartmodel;
    notifyListeners();
  }

  Future<void> setCategory(BuildContext context) async {
    Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _categoryModel = await category(context, accesstoken);
      if (_categoryModel != null) {
        _category = _categoryModel!.category;
        // ignore: use_build_context_synchronously
        setBranch(context);
        setTopTenProducts(context);
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, user_route.Route.productpage).then((value) {
        Navigator.pop(context);
      });

      notifyListeners();
    }
  }

  /////////// get products all
  Future<void> setProducts(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({});
    if (accesstoken.isNotEmpty) {
      _productsModel = await products(context, accesstoken, payload);
      if (_productsModel != null) {
        _products = _productsModel!.products;
        if (_products.isNotEmpty) {
          Navigator.pushNamed(context, user_route.Route.productsall);
        }
      }
      notifyListeners();
    }
  }

  /////////// get products by category id
  Future<void> setProductsById(BuildContext context, String id) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'category_id': id});
    if (accesstoken.isNotEmpty) {
      _productsModel = await products(context, accesstoken, payload);
      if (_productsModel != null) {
        _products = _productsModel!.products;
        Navigator.pushNamed(context, user_route.Route.productsall);
      }
      notifyListeners();
    }
  }

  ///////////// get top ten products
  Future<void> setTopTenProducts(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _topTenProductModel = await toptenProducts(context, accesstoken);
      if (_topTenProductModel != null) {
        _topTenProduct = _topTenProductModel!.products;
      }
    }
    notifyListeners();
  }

  //////// get to branch
  Future<void> setBranch(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _branchModel = await branchModel(context, accesstoken);
      if (_branchModel != null) {
        _branch = _branchModel!.topBranch;
      }
    }
    notifyListeners();
  }

  Future<void> setProductByBranch(BuildContext context, String branchId) async {
    Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'branch_id': branchId});
    if (accesstoken.isNotEmpty) {
      _productbybranch = await productByBranch(context, accesstoken, payload);
      if (_productbybranch != null) {
        _productbybranchlist = _productbybranch!.products;
        Navigator.pushNamed(context, user_route.Route.productbybranch)
            .then((val0) {
          Navigator.pop(context);
        });
      }
      notifyListeners();
    }
  }
}
