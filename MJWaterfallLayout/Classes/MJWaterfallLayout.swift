//
//  MJWaterfallLayout.swift
//  ZMJWaterfallLayout
//
//  Created by 张小凡 on 2017/6/5.
//  Copyright © 2017年 张小凡. All rights reserved.
//

import UIKit

//MARK: - 数据源
protocol MJWaterfallLayoutDataSource : class{
    
    func highForCell(_ layout: UICollectionViewFlowLayout , itemIndex: Int) -> CGFloat
    
    
    
    
    
    
}

class MJWaterfallLayout: UICollectionViewFlowLayout {

    var itemMaxH : CGFloat = 0
    
    //每一排的个数
    var LineNum : Int = 3
    
    //数据源
    weak var dataSource : MJWaterfallLayoutDataSource?
    
    fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
}

//MARK: - 准备所有布局
extension MJWaterfallLayout{
    
    
    

    override func prepare() {
        
        super.prepare()
        
        attributes.removeAll()
        
        //拿到所有的cell
        
        //1.拿到cell的个数
        guard let collectionView = collectionView  else {
            return
        }
        
        let count = collectionView.numberOfItems(inSection: 0)
        
        //2.给每一个cell设置一个Attributes(相当于frame)

        
        //item的宽度
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(LineNum) - 1) * minimumInteritemSpacing) / CGFloat(LineNum)
        
        //缓存每行的高度
        var heights : [CGFloat] = Array(repeating: sectionInset.top, count: LineNum)
        
        //遍历所有的item给其放在最合适的位置(从高度最矮的地方开始排)
        for i in 0..<count {
            
            let indexPath = IndexPath(item: i, section: 0)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //从高度最矮的地方开始排列(获取行高度中最矮的那个的位置)
            let minHigh = heights.min()!
            
            let minHighIndex = heights.index(of: minHigh)!
            
            
            //3.给Attributes设置frame
            
            //3.1 随机的高度
            let itemH = dataSource?.highForCell(self, itemIndex: i) ?? 100
            
            let itemX = sectionInset.left + (minimumInteritemSpacing + itemW) * CGFloat(minHighIndex)
            
            let itemY = minHigh
            
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            attributes.append(attribute)
            
            //添加高度后更新对应的高度缓存值
            heights[minHighIndex] = attribute.frame.maxY + minimumLineSpacing
            
        }
        
        //获取最大的高度
        itemMaxH = heights.max()! - minimumLineSpacing
        
    }

}



//MARK: - 告诉系统准备好了布局
extension MJWaterfallLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributes
        
    }
}


//告诉系统滚动范围
extension MJWaterfallLayout{
    
    override var collectionViewContentSize: CGSize{
    
        return CGSize(width: 0, height: itemMaxH + sectionInset.bottom)
    
    }
    
}




