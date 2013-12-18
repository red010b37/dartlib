library dartlib.services.endpoints.Endpoint;

//CORE
import 'dart:html';
import 'dart:async';
import 'dart:convert';

// PACKAGES
import 'package:logging/logging.dart';

// IMPORTS



/**
 * This class allows us to easily connect to our endpoints without
 * the goolge js lib as it is average
 * 
 * This should be used as a new class with a temp var everytime to 
 * maximise usabiliy, minimise ui blocking and stop completer errors.
 * 
 *     function () {
 *       var endpoint = new Endpoint();
 *       endpoint.sendData().then((e)=>function(e));
 *      }
 * 
 *
 */
class Endpoint
{
  
  Completer completer;
  HttpRequest _httpRequest;
  Logger _logger = new Logger("Endpoint");
  
  /// ID that will be returned once the load is complete
  String id;
  
  /**
   * Requests the endpoint service for any url and data given
   * 
   *     retrun Future
   */
  Future sendData(String url, {String method: "POST", Map data: null, String loaderId : "0", String contentType:"application/json", String token:"" })
  {
    
    id = loaderId;
    
    String tokenKey = token;
    print(tokenKey);
  
    //_logger.info("Requesting endpoint - $url with token $token" );
    print("Requesting endpoint - $url with token $tokenKey" );
    
    String sendData = "";
    if(data != null)
    {
      sendData = JSON.encode(data);
    }
     
    _logger.info("Sending data: $sendData");

    completer = new Completer();
    
    _httpRequest = new HttpRequest()
      ..open(method, url)
      ..setRequestHeader("Authorization", "Bearer " + tokenKey)
      ..setRequestHeader("Content-type", "application/json")
      ..onLoadEnd.listen((e) => _loadEnd(_httpRequest))
      ..overrideMimeType("application/json")
      ..send(sendData);
    
      
    return completer.future;
  }
  
  
  Future<String> _loadEnd(HttpRequest request)
  {
    _logger.info("endpoint complete with status: ${request.status}");
    
    Map resp = new Map();
    resp['id'] = id;
    resp['data'] = request.responseText;
    
    print(request.responseText);
    
    if (request.status == 200) {
     
      
     // _logger.info("Status ok");
     // _logger.info("Data Recived :" + request.responseText.toString() );
      
      completer.complete(resp);
      
    } else {
      //_logger.warning("Error");
      //_logger.warning("Data Recived :" + request.responseText );
      
      completer.completeError(resp);
    }
  }
}