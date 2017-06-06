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
    
    fileprivate var cellNum : Int = 20
    
    lazy var collection : UICollectionView = {
        
        let layout = MJWaterfallLayout()
        
        layout.minimumInteritemSpacing = 10
        
        layout.minimumLineSpacing = 10
        
        layout.LineNum = 2
        
        layout.dataSource = self
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let col : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        col.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        col.dataSource = self
        
        col.delegate = self
        
        return col
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        collection.delegate = self
        view.addSubview(collection)
        
        
        
    }
    
}


extension ViewController : MJWaterfallLayoutDataSource{

    func highForCell(_ layout: UICollectionViewFlowLayout, itemIndex: Int) -> CGFloat {
        
        return CGFloat(arc4random_uniform(200) + 30)
        
        
    }

}


//MARK: - UICollectionView的代理和数据源方法方法

extension ViewController: UICollectionViewDataSource , UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = UIColor.cz_random()
        
     
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height) {
            
            cellNum += 20
            
            collection.reloadData()
            
        }
        
    }
    
    
    
}

