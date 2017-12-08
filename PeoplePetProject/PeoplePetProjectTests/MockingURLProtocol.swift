//
//  MockingURLProtocol.swift
//  PeoplePetProjectTests
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import Foundation

class MockingURLProtocol: URLProtocol {

    private let cannedHeaders = ["Content-Type": "application/json; charset=utf-8"]

    override class func canInit(with request: URLRequest) -> Bool {
        return ["http", "https"].contains(request.url?.scheme ?? "")
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = Mocks.find(request),
            let url = request.url,
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: cannedHeaders) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}
