//
//  ServicesCollectionLayout.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class ServicesCollectionLayout: UICollectionViewLayout {

    fileprivate var numberOfColumns: Int = 2
    fileprivate var cellPadding: CGFloat = 20
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentWitdh: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right) - (cellPadding * (CGFloat(numberOfColumns) - 1))
    }
    fileprivate var contentHeight: CGFloat = 0

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWitdh, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let itemsPerRow: Int = 2
        let normalColumnWidth: CGFloat = contentWitdh / CGFloat(itemsPerRow)
        let normalColumnHeight: CGFloat = normalColumnWidth * 0.9
        let featuredColumnWidth: CGFloat = (normalColumnWidth * 2) + cellPadding
        let featuredColumnHeight: CGFloat = normalColumnHeight
        var xOffsets: [CGFloat] = [CGFloat]()
        //add xPos of Featured
        xOffsets.append(0.0)
        for item in 1..<7 {
            let multiplier = (item + 1) % 2
            let xPos = CGFloat(multiplier) * (normalColumnWidth + cellPadding)
            xOffsets.append(xPos)
        }

        var yOffsets: [CGFloat] = [CGFloat]()

        for item in 0..<7 {
            let yPos = item == 0 ? 0 : floor(Double((item + 1) / 2)) * (Double(normalColumnHeight) + Double(cellPadding))
            yOffsets.append(CGFloat(yPos))
        }
        let numberOfItemsPerSection: Int = 7
        let heightOfSection: CGFloat = 4 * (normalColumnHeight + cellPadding)
        var itemInSection = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let xPos = xOffsets[itemInSection]
            let multiplier: Double = floor(Double(item) / Double(numberOfItemsPerSection))
            let yPos = yOffsets[itemInSection] + (heightOfSection * CGFloat(multiplier))
            var cellWidth = normalColumnWidth
            var cellHeight = normalColumnHeight
            if itemInSection == 0 {
                cellWidth = featuredColumnWidth
                cellHeight = featuredColumnHeight
            }
            let frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            itemInSection = itemInSection < (numberOfItemsPerSection - 1) ? (itemInSection + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return (self.collectionView?.bounds ?? newBounds) == newBounds
    }
}
