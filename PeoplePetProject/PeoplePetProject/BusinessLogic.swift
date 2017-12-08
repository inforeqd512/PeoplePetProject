//
//  File.swift
//  PeoplePetProject
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import Foundation
import SwaggerClient

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:[Element]] {
        var dict = [Key:[Element]]()
        for element in self {
            let key = selectKey(element)
            if dict[key] == nil {
                dict[key] = []
            }
            if let x = dict[key] {
                dict[key] = x + [element]
            }
        }
        return dict
    }
}

func createDatasource(from people:[Person]?) -> [String:[String]] {
    let x =
        people?
            .map({ (person) -> CatOwnerDetail in    //map to gender, array of cat names
                let ownerGender = person.gender.rawValue
                let catNames =
                person.pets?
                    .filter({ (pet) -> Bool in
                        return pet.type.rawValue.uppercased() == "CAT"
                    })
                    .map({ (pet) -> String in
                        return pet.name
                    })
                return CatOwnerDetail(ownerGender: ownerGender, catNames: catNames ?? [])
            })
            .reduce(into: [:], { (dictionary, catOwnerDetail) in    //reduce to dictionary of gender and ALL cat names
                let key = catOwnerDetail.ownerGender
                if let value = dictionary[key] {
                    let nextValue = value + catOwnerDetail.catNames
                    dictionary[key, default: [] ] = nextValue
                } else {
                    dictionary[key, default: [] ] = catOwnerDetail.catNames
                }
            })
            .mapValues({ (value:[String]) -> [String] in    //sort the cat names
                return value.sorted()
            })


    if let y = x as? [String : [String]] { //unwrap the optional
        return y
    } else {
        return [:]
    }
}


