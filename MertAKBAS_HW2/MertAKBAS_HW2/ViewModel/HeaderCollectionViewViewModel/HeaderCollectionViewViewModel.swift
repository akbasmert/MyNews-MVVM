//
//  HeaderCollectionViewViewModel.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 15.05.2023.
//

import Foundation

class HeaderCollectionViewViewModel: NSObject {
    
    private(set) var headerDataModel: [DynamicHeaderCVViewModel]!
    
    override init() {
        super.init()
    }

    convenience init(headerDataModel: [DynamicHeaderCVViewModel]) {
        self.init()
        self.headerDataModel = headerDataModel
    }
}

struct DynamicHeaderCVViewModel {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
