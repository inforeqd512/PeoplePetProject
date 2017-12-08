//
//  MockURLSession.swift
//  PeoplePetProjectTests
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import SwaggerClient
import Alamofire
@testable import PeoplePetProject

class MockAlamofireRequestBuilder : AlamofireDecodableRequestBuilder<People> {

    open override func createSessionManager() -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = buildHeaders()
        configuration.protocolClasses = [MockingURLProtocol.self]
        return Alamofire.SessionManager(configuration: configuration)
    }
}

class MockPetAPI: PetsV1API {

    open class func getMockPetsWithRequestBuilder(path: String) -> MockAlamofireRequestBuilder {
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let requestBuilder = MockAlamofireRequestBuilder(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)

        return requestBuilder
    }

    open override class func getPets(completion: @escaping ((_ data: People?,_ error: Error?) -> Void)) {
        self.getMockPetsWithRequestBuilder(path: "/people.json").execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    open class func getNoPets(completion: @escaping ((_ data: People?,_ error: Error?) -> Void)) {
        self.getMockPetsWithRequestBuilder(path: "/peopleNoPets.json").execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

}
