import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';
import 'package:flutter_mvvm/model/costs/result.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  bool isLoading = false;

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> originCityList = ApiResponse.completed([]);
  ApiResponse<List<City>> destinationCityList = ApiResponse.completed([]);
  ApiResponse<Result> serviceCost = ApiResponse.completed(const Result());

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  setOriginList(ApiResponse<List<City>> response) {
    originCityList = response;
    notifyListeners();
  }

  setDestinationList(ApiResponse<List<City>> response) {
    destinationCityList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getOriginList(var provId) async {
    setOriginList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setOriginList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOriginList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getDestinationList(var provId) async {
    setDestinationList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setDestinationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDestinationList(ApiResponse.error(error.toString()));
    });
  }

  setServiceCost(ApiResponse<Result> response) {
    serviceCost = response;
    notifyListeners();
  }

  Future<void> calculateServiceCost(
      {required String origin,
      required String destination,
      required int weight,
      required String service}) async {
    setServiceCost(ApiResponse.loading());
    _homeRepo
        .calculateShippingCost(
      origin: origin,
      destination: destination,
      weight: weight,
      result: service,
    )
        .then((value) {
      setServiceCost(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setServiceCost(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }
}
