//
//  NewsViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 15.05.2023.
//

import UIKit

class NewsViewController: UIViewController, LoadingShowable, UINavigationControllerDelegate {
    
    var imageUrl: String?
    var newsTitle: String?
    var newsDescription: String?
    var newsAuthor: String?
    var newsUrl: String?
    var key: String = "home"
    
    var viewModel: HeaderCollectionViewViewModel = HeaderCollectionViewViewModel(headerDataModel: [DynamicHeaderCVViewModel(title: "Home"),DynamicHeaderCVViewModel(title: "Automobiles"),DynamicHeaderCVViewModel(title: "Arts"),DynamicHeaderCVViewModel(title: "Health"),DynamicHeaderCVViewModel(title: "Travel"),DynamicHeaderCVViewModel(title: "World"),DynamicHeaderCVViewModel(title: "Business"),DynamicHeaderCVViewModel(title: "Food")])
    
    var newsViewModel: NewsViewModelProtocol! {
        didSet {
            newsViewModel.delegate = self
        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
        navigationItem.title = "MY NEWS"
        
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        headerCollectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .left)
        
        view.addSubview(headerCollectionView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
              headerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
              headerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              headerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              headerCollectionView.heightAnchor.constraint(equalToConstant: 50.0),
              
              collectionView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor),
              collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
        newsViewModel.fetchData(key: self.key)
    }
        
    private lazy var headerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize =  UICollectionViewFlowLayout.automaticSize
     
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .lightGray
        view.showsHorizontalScrollIndicator = false
        view.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        view.reloadData()
      
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

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
        
        if self.collectionView == collectionView {
            return  newsViewModel.numberOfItems
        } else {
            return  viewModel.headerDataModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if self.collectionView == collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? DynamicNewsCollectionViewCell else {
                fatalError("no cell")
            }
            
            if let news = self.newsViewModel.news(indexPath.row) {
                cell.updateSubViews(news: news)
            }
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as? HeaderCollectionViewCell
            else {
                fatalError("no cell")
            }
            cell.viewModel = viewModel.headerDataModel[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.collectionView == collectionView {
            
            if let news = self.newsViewModel.news(indexPath.row) {
                self.imageUrl = news.multimedia?[0].url
                self.newsTitle = news.title
                self.newsDescription = news.abstract
                self.newsAuthor = news.byline
                self.newsUrl = news.url
            }
            
            performSegue(withIdentifier: "toDetailVC", sender: nil)
            collectionView.deselectItem(at: indexPath , animated: true)
            
        } else {
            
            newsViewModel.headerNewsDidSelect(index: indexPath)
            headerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            
            let indexPathCollectionView = IndexPath(item: 0, section: 0)
            self.collectionView.scrollToItem(at: indexPathCollectionView, at: .top, animated: true)
        }
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
        
        if self.collectionView == collectionView {
            let width = view.bounds.size.width
            let newsCellSize = DynamicNewsCollectionViewCell.expectedCardSize(CGSize(width: (width - 36), height: 0.0))
            
            return newsCellSize
        } else {
            let headerViewModel = viewModel.headerDataModel[indexPath.row]
            let headerNewSize = HeaderCollectionViewCell.expectedCardSize(CGSize(width: 0.0, height: 30), viewModel: headerViewModel)
            
            return headerNewSize
        }
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
