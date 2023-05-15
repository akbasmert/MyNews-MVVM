//
//  NewsViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 15.05.2023.
//

import UIKit

class NewsViewController: UIViewController, LoadingShowable {
    var imageUrl: String?
    var newsTitle: String?
    var newsDescription: String?
    var newsAuthor: String?
    var newsUrl: String?
    var key: String = "home"
    
    var newsViewModel: NewsViewModelProtocol! {
        didSet {
            newsViewModel.delegate = self
        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsViewModel.fetchData(key: self.key)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        private lazy var collectionView: UICollectionView = {
            
           let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.estimatedItemSize =  UICollectionViewFlowLayout.automaticSize // CGSize(width: self.view.bounds.size.width, height: 40.0)
           
            let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
            view.delegate = self
            view.dataSource = self
            
            view.backgroundColor = .lightGray
            
          
            
            view.register(DynamicNewsCollectionViewCell.self, forCellWithReuseIdentifier: DynamicNewsCollectionViewCell.reuseIdentifier)
            view.reloadData()
            return view
        }()

    }

    extension NewsViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newsViewModel.numberOfItems
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? DynamicNewsCollectionViewCell else {
                fatalError("no cell")
            }
            if let news = self.newsViewModel.news(indexPath.row) {
                cell.updateSubViews(news: news)
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            if let news = self.newsViewModel.news(indexPath.row) {
                self.imageUrl = news.multimedia?[0].url
                self.newsTitle = news.title
                self.newsDescription = news.abstract
                self.newsAuthor = news.byline
                self.newsUrl = news.url
            }
            
            performSegue(withIdentifier: "toDetailVC", sender: nil)
            collectionView.deselectItem(at: indexPath , animated: true)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailVC" {
                let destinationDetailVC = segue.destination as! DetailViewController
                destinationDetailVC.imageUrl = self.imageUrl
                destinationDetailVC.newsTitle = self.newsTitle
                destinationDetailVC.newsDescription = self.newsDescription
                destinationDetailVC.newsAuthor = self.newsAuthor
                destinationDetailVC.newsUrl = self.newsUrl
            }
        }
    }

    extension NewsViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if (self.newsViewModel.news(indexPath.row)) != nil {
            }
            let width = view.bounds.size.width
            let newSize = DynamicNewsCollectionViewCell.expectedCardSize(CGSize(width: (width - 36)/2, height: 0.0))
            return newSize
        }
    }

extension NewsViewController: ViewModelDelegate {
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
