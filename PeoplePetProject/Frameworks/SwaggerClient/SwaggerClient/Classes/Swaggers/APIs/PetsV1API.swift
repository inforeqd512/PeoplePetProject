//
// PetsV1API.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class PetsV1API {
    /**
     gets the pet list
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPets(completion: @escaping ((_ data: People?,_ error: Error?) -> Void)) {
        getPetsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     gets the pet list
     - GET /people.json
     - gets the pet list
     - examples: [{contentType=application/json;charset=UTF-8, example=""}]

     - returns: RequestBuilder<People> 
     */
    open class func getPetsWithRequestBuilder() -> RequestBuilder<People> {
        let path = "/people.json"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<People>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
