//
//  NewsViewModel.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import Foundation
import MertAKBAS_HW2API

protocol NewsViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    
    func fetchData(key: String)
    func news(_ index: Int) -> News?
    func headerNewsDidSelect( index: IndexPath)
}

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
        self.delegate?.showLoadingView()
        service.fetchPopularNews(key: key) { [weak self] response in
            guard let self else { return }
            self.delegate?.hideLoadingView()
            switch response {
                
            case .success(let news):
                self.news = news
                self.delegate?.reloadData()
            case .failure(_):
                break
            }
        }
    }
}

extension NewsViewModel: NewsViewModelProtocol {
    func headerNewsDidSelect(index: IndexPath) {
        switch index.row {
        case 0:
            fetchData(key: "home")
        case 1:
            fetchData(key: "automobiles")
        case 2:
            fetchData(key: "arts")
        case 3:
            fetchData(key: "health")
        case 4:
            fetchData(key: "travel")
        case 5:
            fetchData(key: "world")
        case 6:
            fetchData(key:  "business")
        default:
            fetchData(key:  "food")
        }
    }
    
    var numberOfItems: Int {
        news.count
    }
    
    func fetchData(key: String) {
        fetchNews(key: key)
    }
    
    func news(_ index: Int) -> News? {
        news[index]
    }
}
