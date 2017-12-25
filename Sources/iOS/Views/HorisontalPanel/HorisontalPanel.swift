//
//  HorisontalPanel.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 25/12/2017.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

public protocol HorisontalPanelDelegate : class {
    var horisontalPanelButtonTitles: [String] { get }
    func horisontalPanelDidSelectIndex(_ index: Int)
}

public class HorisontalPanel : IBDesignableView {
    
    @IBOutlet var collectionView: UICollectionView!
    
    public var delegate: HorisontalPanelDelegate!
    public var margin: CGFloat = 10
    public var font: UIFont = UIFont.systemFont(ofSize: 17)
    public var color: UIColor = UIColor.gray
    public var selectedColor: UIColor = UIColor.black
    public var selectedIndex: Int = -1 { didSet { collectionView.reloadData() } }
    
    private var titles: [String] { return delegate.horisontalPanelButtonTitles }
    
    private var flowLayout: UICollectionViewFlowLayout! {
        return self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    public override func setup() {
        HorisontalPanelCell.registerFor(collectionView)
        if #available(iOS 10.0, *) {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else { Log.error() }
        flowLayout.scrollDirection = .horizontal
    }
}

//MARK: - UICollectionViewDataSource

extension HorisontalPanel : UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if delegate == nil { return 0 }
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if delegate == nil { return UICollectionViewCell() }
        return collectionView.getCell(HorisontalPanelCell.self, indexPath: indexPath) { cell in
            cell.labelHeight.constant = self.height
            cell.setNeedsLayout()
            cell.label.font = self.font
            cell.label.text = self.titles[indexPath.row]
            cell.label.textColor = self.color
            if indexPath.row == self.selectedIndex {
                cell.label.textColor = self.selectedColor
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HorisontalPanel : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate.horisontalPanelDidSelectIndex(indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

