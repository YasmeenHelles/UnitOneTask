//
//  MyAPi.swift
//


import Foundation
import Alamofire
import  AlamofireImage

let  header: [String:String] = ["Accept":"application/json"]

class MyApi: NSObject {
    static var api = MyApi()
    //MARK: Requests Functions

 
    
    func sendRequestGet(urlString:String ,_ auth :[String:String]?, completion:((NSDictionary?,String,Bool)->Void)!)
    {
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: auth)
            .validate(statusCode: 200..<500)
            .responseJSON
            { response in
                
                if(response.result.isSuccess)
                {
                    if let resp = response.result.value as? NSDictionary {
                        let status = resp.value(forKey: "status") as? Bool ?? false
                        let message = resp.value(forKey: "message") as? String ?? ""
                       
                        completion(resp,message,status)
                    }else {
                        completion(nil,"ServerError",false)
                    }
                    
                }
                else
                {
                    completion(nil,response.result.error.debugDescription,false)
                }
        }
    }
    
    
    func getHomeData(completion:((Bool,String,[Slider],[Slider])->Void)!){
        
        let url = Constant.GetHomeData
        sendRequestGet( urlString:url, header) { (response, message, success) in
            if success {
                let item = response!.value(forKey: "data") as? [String:Any] ?? [:]
                let sliderData = item["slider"]as? [[String:Any]] ?? []
                let citiesData = item["allCities"]as? [[String:Any]] ?? []
                var arraySlider:[Slider] = []
                var arrayCities:[Slider] = []

                for i in sliderData {
                    arraySlider.append(Slider(i))
                }
                for i in citiesData {
                    arrayCities.append(Slider(i))
                }
                completion(success,message,arraySlider,arrayCities)
            }
            else {
                completion(success,message,[],[])
            }
        }
    }
    
    
}
