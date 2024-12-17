import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:example/Model/CityModel.dart';
import 'package:example/Model/ClientModel.dart';
import 'package:example/Model/CountryModel.dart';
import 'package:example/Model/StatesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MainProvider with ChangeNotifier{
  CountryModel? selectedCountry;
  CountryModel? selectedCountry1;
  StatesModel? selectedState;
  CityModel? selectedCity;

  List<StatesModel> tempStatesList = [];
  List<CountryModel> countryList = [];
  List<StatesModel> statesList = [];
  List<CityModel> tempCityList = [];
  List<CityModel> cityList = [];


  Future<void> loadCity() async {
    cityList = [];

    var data = await rootBundle.loadString("assets/JsonFiles/City.json");
    var cityData = json.decode(data);
    List list = cityData['city'].cast<Map<String, dynamic>>();
    cityList.addAll(list.map((e) => CityModel.fromJson(e)).toList());
    notifyListeners();

  }

  Future<void> loadState() async {
    statesList = [];
    var data = await rootBundle.loadString("assets/JsonFiles/State.json");
    var stateData = json.decode(data);
    List list = stateData['states'].cast<Map<String, dynamic>>();
    statesList.addAll(list.map((e) => StatesModel.fromJson(e)).toList());
    notifyListeners();
  }

  Future<void> loadCountry() async {
    countryList = [];
    var data = await rootBundle.loadString("assets/JsonFiles/Country.json");
    var countryData = json.decode(data);
    List list = countryData['countries'].cast<Map<String, dynamic>>();
    countryList.addAll(list.map((e) => CountryModel.fromJson(e)).toList());
    notifyListeners();
  }

  getAllLocation(){
    loadCity();
    loadState();
    loadCountry();
    notifyListeners();
  }


  ClientModel? selectedClient;
  List<ClientModel> clientList = [];
  bool isLoading = false;
  var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFsa"
      "XNoYSIsInNlY3JldCI6InRlc3QiLCJwYXNzd29yZCI6IkFsaXNoYUAxIiwicm9sZSI6IkFkbW"
      "luIiwiaWQiOjI1LCJ1c2VyVHlwZSI6ImFkbWluIiwicm9sZUlkIjo5MCwidXNlcl9hY2Nlc3"
      "MiOiJhZG1pbiIsImlhdCI6MTczNDA4NzM1NCwiZXhwIjoxNzM2Njc5MzU0LCJhdWQiOiJhZG1"
      "pbiIsImlzcyI6ImFkbWluIiwic3ViIjoiYWRtaW4ifQ.t7bSFWCMwSr37ApcX7SO1ALYDR2I9"
      "gcPs2FyNeIORbU";

  Future<List<ClientModel>> getClient(String searchValue) async{
    isLoading = true;
    notifyListeners();

    var  params = {
      "_search":searchValue,
      "limit":"10",
      "page":"1"
    };

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/admin/client/list',params);


    http.Response response = await http.get(
      baseUrl,
      headers:{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': accessToken
      },
    );


    var value = json.decode(response.body);
    if (response.statusCode == 200 && value["success"] == true) {
      clientList = [];
      final items = value["data"]["data"].cast<Map<String, dynamic>>();
      List<ClientModel> list = items.map<ClientModel>((val) {
        return ClientModel.fromJson(val);
      }).toList();
      clientList.addAll(list);
      isLoading = false;
      notifyListeners();
    }else {
      isLoading = false;
      notifyListeners();
    }

    return clientList;
  }


  clearCountry(){
    tempCityList = [];
    tempStatesList = [];
    selectedCity = null;
    selectedState = null;
    selectedCountry = null;
    loadCountry();
    notifyListeners();
  }

  countryOnChange(value){
    selectedCountry = value;
    selectedCountry1 = value;
    selectedCity = null;
    selectedState = null;
    tempStatesList = [];
    tempCityList = [];
    tempStatesList = statesList.where((element) {
      return "${element.countryId}" == "${selectedCountry?.id}";
    }).toList();
    notifyListeners();
  }

  clearState(){
    selectedState = null;
    if(selectedCountry == null) tempStatesList.clear();
    notifyListeners();
  }

  stateOnChange(value){
    tempCityList = [];
    selectedCity = null;
    selectedState = value;

    tempCityList = cityList.where((element) {
      return "${element.stateId}" == "${selectedState?.id}";
    }).toList();
    notifyListeners();
  }


  clearCity(){
    selectedCity = null;
    if(selectedState == null) tempCityList.clear();
    notifyListeners();
  }

  cityOnChange(value){
    selectedCity = value;
    notifyListeners();
  }



}