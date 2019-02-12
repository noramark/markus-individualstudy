//
//  HomeFeedViewController.swift
//  
//
//  Created by Eleanor Markus-19 on 2/5/19.
//

import UIKit
import Firebase

class HomeFeedViewController: UIViewController, UICollectionView   {
    private let reuseIdentifier = "FeedCell"
    var model:[PostModel]?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad(){
        super.viewDidLoad()
        loadData()
    }
    func loadData() {
        model = []
    }
}
