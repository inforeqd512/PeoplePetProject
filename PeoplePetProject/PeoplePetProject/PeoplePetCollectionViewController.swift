//
//  PeoplePetCollectionViewController.swift
//  PeoplePetProject
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import UIKit
import SwaggerClient

class PetCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}

class GenderSectionView: UICollectionReusableView {
    @IBOutlet weak var imageView: UIImageView!
}

class PeoplePetCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let viewModel = ViewModel()
    let repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(from: repository) {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.identifier(for: .cell), for: indexPath)

        if let cell = cell as? PetCell {
            let rgb = viewModel.backgroundColor(for: .cell)
            cell.backgroundColor = UIColor(red: rgb.red, green: rgb.blue, blue: rgb.green, alpha: rgb.alpha)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = viewModel.bezel(for: .cell)
            cell.label.text = viewModel.cellLabel(for: indexPath)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewModel.identifier(for: .header), for: indexPath as IndexPath) as! GenderSectionView
            let rgb = viewModel.backgroundColor(for: .header)
            headerView.backgroundColor = UIColor(red: rgb.red, green: rgb.blue, blue: rgb.green, alpha: rgb.alpha)
            headerView.imageView.image = UIImage(named: viewModel.headerImageName(for: indexPath.section))
            return headerView

        case UICollectionElementKindSectionFooter: return UICollectionReusableView(frame: .zero)
        default:
            assert(false, "Unexpected element kind")
        }

    }
}
