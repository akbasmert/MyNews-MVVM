//
//  UICollectionViewCell+Extension.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
