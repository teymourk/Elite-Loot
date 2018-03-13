//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


//Mark: - CollectionHeader
extension Browse {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: Header_Cell = collectionView.reusableCell(indexPath: indexPath, kind: kind)
        header.title = indexPath.section == 0 ? "Events" : "Games"
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 40)
    }
}

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupCollectionView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .customGray
        collectionView?.registerCell(Events_Cell.self)
        collectionView?.registerCell(Games_Cell.self)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let eventsCell: Events_Cell = collectionView.reusableCell(indexPath: indexPath)
        let gamesCell: Games_Cell = collectionView.reusableCell(indexPath: indexPath)
     
     return indexPath.section == 0 ? eventsCell : gamesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 160)
                
        }
        
        return CGSize(width: view.frame.width, height: 64)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
 
}

/*

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @objc func sendAlert() {
        let alert = UIAlertController(title: "Not Signed In", message: "Sign in to start favoriting games.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func refreshBrowse() {
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    private let cellId = "cellId"
   var browseCategories: [BrowseCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendAlert), name: NSNotification.Name(rawValue: "sendAlertBrowse"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBrowse), name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
        
        let user = Auth.auth().currentUser?.uid
         if user != nil
         {Database.database().reference().child("users").child(user!).child("favorites").observe(.childChanged, with: { (snapshot) in
         print ("Changes: ", snapshot)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)
        //self.collectionView?.reloadData()
        //self.collectionView?.collectionViewLayout.invalidateLayout()
         //Determine if coordinate has changed
         })}
        
        
       
        browseCategories = BrowseCategory.sampleBrowseCategories()
        
        //collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.backgroundColor = .customGray
        collectionView?.register(BrowseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BrowseCell
        
        cell.browseCategory = browseCategories?[indexPath.item]

        return cell
    }
    
    
    
    //num cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = browseCategories?.count {
            return count
        }
        return 0
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 265)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }

}
 
 */

