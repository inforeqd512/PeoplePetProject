//
//  ViewModel.swift
//  PeoplePetProject
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import Foundation
import SwaggerClient

struct RGBColor {
    let red: CGFloat
    let blue: CGFloat
    let green: CGFloat
    let alpha: CGFloat
}

/// view model for collection view
class ViewModel {

    private let cellReuseIdentifier = "PetCell"
    private let headerReuseIdentifier = "GenderSectionView"

    enum State {
        case loading
        case loaded
    }

    enum ViewType {
        case header
        case cell
    }

    var dataSource: [String:[String]]?
    var state: State = .loading

    func load(from repository: Repository, completion: @escaping (() -> Swift.Void)) -> Void {
        repository.latestDataSource { (peoplePetDictionary, error) in
            self.state = .loaded
            self.dataSource = peoplePetDictionary
            completion()
        }

    }

    private func key(for section: Int) -> String {
        precondition(section < 3)
        switch section {
        case 0:
            return Person.Gender.male.rawValue
        case 1:
            return Person.Gender.female.rawValue
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func numberOfSections() -> Int {
        return (dataSource?.count ?? 0)
    }

    func numberOfItems(in section: Int) -> Int {
        return (dataSource![key(for: section)]?.count ?? 0)
    }

    func headerImageName(for section: Int) -> String {
        precondition(section < 3)
        switch section {
        case 0:
            return Person.Gender.male.rawValue
        case 1:
            return Person.Gender.female.rawValue
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func cellLabel(for indexPath:IndexPath) -> String {
        return dataSource![key(for: indexPath.section)]![indexPath.row]
    }

    func backgroundColor(for viewType: ViewType) -> RGBColor {
        switch viewType {
        case .header:
            return RGBColor(red: 255.0/255.0, blue: 255.0/255.0, green: 255.0/255.0, alpha: 1.0)
        case .cell:
            return RGBColor(red: 211.0/255.0, blue: 211.0/255.0, green: 211.0/255.0, alpha: 1.0)
        }
    }

    func bezel(for viewType: ViewType) -> CGFloat {
        switch viewType {
        case .header:
            return 0.0
        case .cell:
            return 8.0
        }
    }

    func identifier(for viewType: ViewType) -> String {
        switch viewType {
        case .header:
            return headerReuseIdentifier
        case .cell:
            return cellReuseIdentifier
        }
    }

}
