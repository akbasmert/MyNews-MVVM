//
//  ViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import UIKit

final class ViewController: UIViewController, LoadingShowable {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newsViewModel: NewsViewModelProtocol! {
        didSet {
            newsViewModel.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsViewModel.fetchData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let width = collectionView.bounds.width
       // let width = self.collectionView.frame.size.width
      //  let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: (width-5)/2, height: 260)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 5
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(cellType: NewsListCell.self)
    }
    
  
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeCell(cellType: NewsListCell.self, indexPath: indexPath)
       // if let movie = self.viewModel.movie(indexPath.row) {
           // cell.configure(moive: movie)
      //  }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        .init(width: newsViewModel.calculateCellHeight(collectionViewWidth: collectionView.frame.size.width).width,
              height: newsViewModel.calculateCellHeight(collectionViewWidth: collectionView.frame.size.width).height
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

