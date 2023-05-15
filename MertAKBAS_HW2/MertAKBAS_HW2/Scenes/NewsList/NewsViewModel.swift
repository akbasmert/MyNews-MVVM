//
//  NewsViewModel.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import Foundation
import MertAKBAS_HW2API
// Altın kural ViewModelin içinde import UIKit yasak

extension NewsViewModel {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
}

// İlerde test yazarken işimizi kolaylaştıracağı için bu protokölü yazdık.
protocol NewsViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    
    func fetchData(key: String)
    func news(_ index: Int) -> News?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
}

// ViewControllerda kullanacağımız fonksiyonları burada listeledik
protocol ViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class NewsViewModel: NSObject {
 
    private var news: [News] = []
    let service: PopularNewsServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: PopularNewsServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchNews(key: String) {
        // TODO: Show loading indicator puan için önemli
        // ViewControllarda loading gösterilmesini iste/haber ver
        self.delegate?.showLoadingView()
        service.fetchPopularNews(key: key) { [weak self] response in
            guard let self else { return }
            // TODO: hide loading
            // ViewControllarda loading gizlemesini iste/haber ver
            self.delegate?.hideLoadingView()
            switch response {
            case .success(let news):
             //   print("Mert: \(movies)")
                self.news = news
                // TODO: collectionview reload data
                // View Controllarda collectionview i güncelle.
                self.delegate?.reloadData()
            case .failure(let error):
                print("Mert: \(error)")
            
        }
    }
    }
}

extension NewsViewModel: NewsViewModelProtocol {
    var numberOfItems: Int {
        news.count
    }
    
    var cellPadding: Double {
        Constants.cellRightPadding
    }
    
    func fetchData(key: String) {
        fetchNews(key: key)
    }
    
    func news(_ index: Int) -> News? {
        news[index] //
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWitdh = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWitdh * Constants.cellPosterImageRatio
        
        return (width: cellWitdh, height: Constants.cellTitleHeight + posterImageHeight)
    }
}
