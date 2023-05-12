//
//  NewsListCell.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import UIKit
import MertAKBAS_HW2API
import SDWebImage

class NewsListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(news: News) {
        //preparePosterImage(with: news.multimedia?.first?.url)
        preparePosterImage(with: news.multimedia?[1].url)
        self.titleLabel.text = news.title
        self.authorLabel.text = news.byline
    }
    
    private func preparePosterImage(with urlString: String?) {
        if let url = URL(string: urlString ?? "") {
            imageView.sd_setImage(with: url)
        }
    }
}
