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
        
//        required convenience init() {
//            self.init()
//             configureAppearance()
//             configureSubviews()
//
//        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
//        private lazy var titleLabel: UILabel = {
//            let view = UILabel()
//            view.numberOfLines = 0
//            view.textColor = UIColor.black
//            view.font = UIFont.boldSystemFont(ofSize: 16.0)
//            view.translatesAutoresizingMaskIntoConstraints = false
//            return view
//        }()
//
//
//        private lazy var messageView: UILabel = {
//            let view = UILabel()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.numberOfLines = 0
//            view.textColor = UIColor.black
//            view.font = UIFont.boldSystemFont(ofSize: 14.0)
//            view.lineBreakMode = .byWordWrapping
//
//
//            return view
//        }()
//
//        private lazy var imageView: UIImageView = {
//            let view = UIImageView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//
//            view.layer.cornerRadius = 10
//            view.clipsToBounds = true
//            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//
//            NSLayoutConstraint.activate([
//                view.widthAnchor.constraint(equalToConstant: 150.0),
//                view.heightAnchor.constraint(equalToConstant: 150.0)
//            ])
//
//            return view
//        }()
//
//        private lazy var containerView: UIStackView = {
//            let view = UIStackView(arrangedSubviews: [imageView,titleLabel,  messageView])
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.backgroundColor = .blue
//            view.layer.cornerRadius = 12.0
//            view.axis = .vertical
//            view.spacing = 12.0
//            return view
//        }()
        
        private lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textColor = UIColor.black
            view.font = UIFont.boldSystemFont(ofSize: 16.0)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.setContentHuggingPriority(.required, for: .vertical) // gives priority to content for vertical compression resistance
            view.setContentCompressionResistancePriority(.required, for: .vertical) // gives priority to content for vertical hugging
            return view
        }()

        private lazy var messageView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.numberOfLines = 0
            view.textColor = UIColor.black
            view.font = UIFont.systemFont(ofSize: 12)
            view.lineBreakMode = .byWordWrapping
            view.setContentHuggingPriority(.required, for: .vertical) // gives priority to content for vertical compression resistance
            view.setContentCompressionResistancePriority(.required, for: .vertical) // gives priority to content for vertical hugging
            return view
        }()
      




//        private lazy var imageView: UIImageView = {
//            let view = UIImageView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.layer.cornerRadius = 12.0
//            view.clipsToBounds = true
//            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            NSLayoutConstraint.activate([
//                view.widthAnchor.constraint(equalToConstant: 150.0),
//                view.heightAnchor.constraint(equalToConstant: 150.0)
//            ])
//            return view
//        }()
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 12.0
            view.clipsToBounds = true
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            let aspectRatioConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 3.0/2.0, constant: 0.0)
            aspectRatioConstraint.isActive = true
            
//            NSLayoutConstraint.activate([
//                view.widthAnchor.constraint(equalToConstant: 150.0),
//                view.heightAnchor.constraint(equalToConstant: 150.0)
//            ])
            return view
        }()

        
        
        private lazy var LabelContainerView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [titleLabel, messageView])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.spacing = 10.0
            view.isLayoutMarginsRelativeArrangement = true // allows layout margins to be applied to arrangedSubviews
            view.layoutMargins = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0) // sets layout margins for arrangedSubviews
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
          //  view.spacing = 10.0
         //   view.isLayoutMarginsRelativeArrangement = true // allows layout margins to be applied to arrangedSubviews
         //   view.layoutMargins = UIEdgeInsets(top: 5.0, left: .zero, bottom: 10.0, right: .zero) // sets layout margins for arrangedSubviews
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
            
            titleLabel.text = news.title
            messageView.text = news.byline
            preparePosterImage(with: news.multimedia?[1].url)
             
        }
        private func preparePosterImage(with urlString: String?) {
            if let url = URL(string: urlString ?? "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png") {
                imageView.sd_setImage(with: url)
            }
        }
    }





    private extension DynamicNewsCollectionViewCell {

//        func configureAppearance() {
//            self.containerView.backgroundColor = .red
//
//        }

        func configureSubviews() {
            contentView.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([contentView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        }
    }
