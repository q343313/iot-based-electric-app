


abstract class ApiServices{

  Future<dynamic>getapidata(String urls);
  Future<dynamic>postapidata(String urls,var data,var header);
  Future<dynamic>deleteuserdata(String urls);

}