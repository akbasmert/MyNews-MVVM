//
//  ViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import UIKit

final class ViewController: UIViewController, LoadingShowable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
        // Do any additional setup after loading the view.
        //let width = collectionView.bounds.width
       // let width = self.collectionView.frame.size.width
      //  let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(cellType: NewsListCell.self)
       
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.key = "home"
            newsViewModel.fetchData(key: self.key)
        case 1:
            self.key = "automobiles"
            newsViewModel.fetchData(key: self.key)
        case 2:
            self.key = "arts"
            newsViewModel.fetchData(key: self.key)
        case 3:
            self.key = "books"
            newsViewModel.fetchData(key: self.key)
        default:
            self.key = "world"
            newsViewModel.fetchData(key: self.key)
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeCell(cellType: NewsListCell.self, indexPath: indexPath)
        if let news = self.newsViewModel.news(indexPath.row) {
            cell.configure(news: news)
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


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      

        .init(width: newsViewModel.calculateCellHeight(collectionViewWidth: collectionView.frame.size.width).width,
              height:350
        )
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero,
              left: newsViewModel.cellPadding,
              bottom: .zero,
              right: newsViewModel.cellPadding)
    }
    
}

extension ViewController: ViewModelDelegate {
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

