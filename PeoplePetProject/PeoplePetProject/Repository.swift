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

    func latestDataSource(completion: @escaping (([String:[String]]?, Error?) -> Void)) -> Void {
        if self.dataSource == nil {
            PetsV1API.getPets(completion: { [weak self] (people, error) in
                self?.dataSource = createDatasource(from: people)
                completion(self?.dataSource, error)
            })
        } else {
            completion(self.dataSource, nil)
        }
    }
}
