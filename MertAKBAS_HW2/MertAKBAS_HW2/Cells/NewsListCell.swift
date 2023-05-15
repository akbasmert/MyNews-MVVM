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
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiView.layer.cornerRadius = 10.0
        uiView.layer.masksToBounds = true
    }
    

    func configure(news: News) {
        preparePosterImage(with: news.multimedia?[1].url)
        if news.title == ""  {self.titleLabel.text = "Title not fouand"} else {self.titleLabel.text = news.title}
        if news.byline != "" {self.authorLabel.text = news.byline} else {self.authorLabel.text = "Byline not found"}
    }
    
    private func preparePosterImage(with urlString: String?) {
        if let url = URL(string: urlString ?? "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png") {
            imageView.sd_setImage(with: url)
        }
    }
}
