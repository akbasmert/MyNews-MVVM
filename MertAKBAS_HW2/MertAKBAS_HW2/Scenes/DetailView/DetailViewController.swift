//
//  DetailViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import UIKit
import SDWebImage
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var newsTitle: String?
    var newsDescription: String?
    var newsAuthor: String?
    var imageUrl: String?
    var newsUrl: String?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsImage.layer.cornerRadius = 15
        seeMoreButton.layer.cornerRadius = 10.0 // İstenilen köşe yuvarlama değerini burada belirtebilirsiniz
        seeMoreButton.layer.masksToBounds = true // Köşe yuvarlaması için fazla içeriği kesmek için bu ayarı kullanabilirsiniz

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchImage(with: imageUrl)
        if newsTitle == "" {titleLabel.text = "Title not found"} else {titleLabel.text = newsTitle}
        if newsDescription == "" {descriptionLabel.text = "Description not found."} else { descriptionLabel.text = newsDescription}
        if newsAuthor != "" {authorLabel.text = newsAuthor} else {authorLabel.text = "Author not found"}
    }
    
    @IBAction func seeMoreButton(_ sender: Any) {
//        let safariVC = detailViewModel.safariService(url: newsUrl!) ?? UIViewController()
        let safariVC = SFSafariViewController(url: URL(string: newsUrl ?? "https://www.nytimes.com/")!)
        present(safariVC, animated: true)
    }
    
    private func fetchImage(with urlString: String?) {
        if let url = URL(string: urlString ?? "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png") {
            newsImage.sd_setImage(with: url)
        }
    }
    
}

