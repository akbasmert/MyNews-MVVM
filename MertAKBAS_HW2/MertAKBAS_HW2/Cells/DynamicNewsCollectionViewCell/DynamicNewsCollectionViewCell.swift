//
//  DynamicNewsCollectionViewCell.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 15.05.2023.
//

import UIKit
import MertAKBAS_HW2API
import SDWebImage

class DynamicNewsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DynamicNewsCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
       //  configureAppearance()
         configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = UIColor.black
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return view
    }()

    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 12)
        view.lineBreakMode = .byWordWrapping
        view.setContentHuggingPriority(.required, for: .vertical) 
        view.setContentCompressionResistancePriority(.required, for: .vertical) // gives priority to content for vertical hugging
        return view
    }()
  
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let aspectRatioConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 3.0/2.0, constant: 0.0)
        aspectRatioConstraint.isActive = true
  

    
        return view
    }()

    private lazy var LabelContainerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10.0
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        return view
    }()

    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, LabelContainerView])
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray4
        } else {
            view.backgroundColor = .white
        }
        view.layer.cornerRadius = 12.0
        view.axis = .vertical
    
        return view
    }()

    private lazy var cardWidth: NSLayoutConstraint = {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let cons = containerView.widthAnchor.constraint(equalToConstant: 1000)
        cons.isActive = true
        return cons
    }()
}

extension DynamicNewsCollectionViewCell {
    
    static func expectedCardSize(_ targetSize: CGSize) -> CGSize {
        let view = DynamicNewsCollectionViewCell()
        let acsize = view.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0.0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return acsize
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        cardWidth.constant = targetSize.width
        
        return containerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}

extension DynamicNewsCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
     func updateSubViews(news: News) {
         if news.title == ""  {self.titleLabel.text = "Title not fouand"} else {self.titleLabel.text = news.title}
         if news.byline != "" {self.authorLabel.text = news.byline} else {self.authorLabel.text = "Byline not found"}

        preparePosterImage(with: news.multimedia?[1].url)
    }
    
    private func preparePosterImage(with urlString: String?) {
        if let url = URL(string: urlString ?? "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png") {
            imageView.sd_setImage(with: url)
        }
    }
}

private extension DynamicNewsCollectionViewCell {
    func configureSubviews() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([contentView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
}

