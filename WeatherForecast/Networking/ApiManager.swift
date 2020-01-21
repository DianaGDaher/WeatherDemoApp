//
//  ApiManager.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation
import Reachability

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    private override init() {
        super.init()
    }
    func getCityWeather(cityName: String, completion: @escaping (_ result: SearchModel?, _ errorMessage: String?) -> Void) {
        let url = BASE_END_POINT + Path.getCityWaether(name: cityName)
        self.makeApiCall(Link: url, Params: "") {(success, _, errorMessage, responseString, statusCode) in
            if success {
                switch statusCode {
                case 200, 201:
                    decodeCodable(responseString: responseString, type: SearchModel.self, successHandler: { (codable) in
                        completion(codable, nil)
                    }) { ( error) in
                        completion(nil, error)
                    }
                case 404:
                    completion(nil, "\(cityName) not found")
                default:
                    completion(nil, errorMessage)
                }
                
            } else {
                completion(nil, errorMessage)
            }
        }
    }
    
    func getCityForecast(longitude: Double, latitude: Double, completion: @escaping (_ result: LocalWeatherModel?) -> Void) {
        let url = BASE_END_POINT + Path.getCityForecast(long: longitude, lat: latitude)
        self.makeApiCall(Link: url, Params: "") { (success, _, errorMessage, responseString, statusCode) in
            if success {
                switch statusCode {
                case 200, 201:
                    decodeCodable(responseString: responseString, type: LocalWeatherModel.self, successHandler: { (codable) in
                        completion(codable)
                    }) { (error) in
                        Utils.showAlert(title: "something_went_wrong".localized(), message: error, cancelButton: "Ok".localized(), style: .alert)
                        completion(nil)
                    }
                default:
                    Utils.showAlert(title: "something_went_wrong".localized(), message: errorMessage, cancelButton: "Ok".localized(), style: .alert)
                    completion(nil)
                }
            }
        }
    }
    // MARK: - Call Link That Return JSON Response
    private func makeApiCall(Link link: String, Method method: String = "GET", Params params: String?, theCompletion:@escaping ((_ success: Bool, _ data: AnyObject, _ errorMessage: String?, _ responseString: String, _ statusCode: Int) -> Void)) {
        
        //Check inernet connection !
        if appNetworking.isConnected() == false {
            theCompletion(false, "" as AnyObject, "no_internet".localized(), "", 0)
            return
        }
        
        let urlString: String? = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlString ?? "")!
        let session = URLSession.shared
        
        let paramString = params ?? ""
        
        var request = URLRequest(url: url)
        request.timeoutInterval = Constants.apiCallTimeout
        request.httpMethod = method
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request) { (data, response, _ ) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                //Status Code
                let httpResponse = response as? HTTPURLResponse ?? HTTPURLResponse()
                
                //If Error
                guard let data = data else {
                    theCompletion(false, "" as AnyObject, "something_went_wrong".localized(), "", httpResponse.statusCode)
                    return
                }
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data) as AnyObject
                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    theCompletion(true, parsedData as AnyObject, "", responseString, httpResponse.statusCode)
                    
                } catch _ {
                    let responseString = String(data: data, encoding: .utf8)
                    let httpResponse = response as? HTTPURLResponse ?? HTTPURLResponse()
                    
                    switch httpResponse.statusCode {
                    case 200, 201:
                        theCompletion(true, "" as AnyObject, nil, responseString ?? "", httpResponse.statusCode)
                    case 404:
                        theCompletion(false, "" as AnyObject, "City not found".localized(), responseString ?? "", httpResponse.statusCode)
                    default:
                        theCompletion(false, "" as AnyObject, "something_went_wrong".localized(), responseString ?? "", httpResponse.statusCode)
                    }
                }
            })
        }
        
        task.resume()
    }
    
}
