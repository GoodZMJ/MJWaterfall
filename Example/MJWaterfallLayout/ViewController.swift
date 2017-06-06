//
//  ViewController.swift
//  MJWaterfallLayout
//
//  Created by 609693897@qq.com on 06/06/2017.
//  Copyright (c) 2017 609693897@qq.com. All rights reserved.
//

import UIKit

import MJWaterfallLayout

fileprivate let cellId = "cellId"

class ViewController: UIViewController {
    
    
    
    lazy var collection : UICollectionView = {
        
        let layout = MJWaterfallLayout()
        
        layout.minimumInteritemSpacing = 10
        
        layout.minimumLineSpacing = 20
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let col : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        col.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        col.dataSource = self
        
        return col
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        collection.delegate = self
        view.addSubview(collection)
        
        
        
    }
    
}

//MARK: - UICollectionView的代理和数据源方法方法

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = UIColor.cz_random()
        
        return cell
        
    }
    
    
    
}

