//
//  Repository.swift
//  PeoplePetProject
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import SwaggerClient

class Repository {

    private var dataSource: [String:[String]]?

    /// Template method to make the api call if datasource not cache or return the transformed data from the cache
    ///
    /// - Parameter completion: callback block to send the datasource to the view controller
    func latestDataSource(completion: @escaping (([String:[String]]?, Error?) -> Void)) -> Void {
        if self.dataSource == nil {
            makeAPICall() { (dataSource, error) in
                self.dataSource = dataSource
                completion(self.dataSource, error)
            }
        } else {
            completion(self.dataSource, nil)
        }
    }

    /// method to make the api call that can be extended if the repository needs to be mocked
    ///
    /// - Parameter completion: callback block to send the datasource 
    func makeAPICall(completion: @escaping (([String:[String]]?, Error?) -> Void)) -> Void {
        PetsV1API.getPets(completion: { (people, error) in
            let dataSource = createDatasource(from: people)
            completion(dataSource, error)
        })
    }
}
