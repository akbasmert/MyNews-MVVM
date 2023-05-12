//
//  NewsListCell.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import UIKit
import MertAKBAS_HW2API

class NewsListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(news: News) {
        preparePosterImage(with: news.multimedia?.first?.url)
        self.titleLabel.text = news.title
    }
    
    private func preparePosterImage(with urlString: String?) {
        
        if let url = URL(string: urlString ?? "") {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    private func loadImage(url: URL) {
        
           DispatchQueue.global().async { [weak self] in
               if let data = try? Data(contentsOf: url) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self?.imageView.image = image
                       }
                   }
               }
           }
       }
}
