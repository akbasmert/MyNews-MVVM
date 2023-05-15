//
//  HeaderCollectionViewCell.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 15.05.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HeaderCollectionViewCell.self)
    
    var viewModel: DynamicHeaderCVViewModel? {
        didSet {
            updateSubViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
         configureSubviews()
    }
    
    required init(viewModel: DynamicHeaderCVViewModel?) {
        self.init()
        self.viewModel = viewModel
         configureSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textColor = UIColor.black
        view.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
  


    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 12.0
        view.axis = .horizontal
        view.spacing = 12.0
        return view
    }()
    
    private lazy var cardWidth: NSLayoutConstraint = {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let cons = containerView.heightAnchor.constraint(equalToConstant: 1000)
        cons.isActive = true
        return cons
    }()
    
}

extension HeaderCollectionViewCell {

    static func expectedCardSize(_ targetSize: CGSize, viewModel:
                                 DynamicHeaderCVViewModel) -> CGSize {
        let view = HeaderCollectionViewCell(viewModel: viewModel)
        let acsize = view.systemLayoutSizeFitting(CGSize(width: 0.0, height: targetSize.height), withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
        return acsize
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        cardWidth.constant = targetSize.height

        return containerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}


extension HeaderCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    private func updateSubViews() {
        
        guard let vm = viewModel else {
            return
        }
        
        titleLabel.text = vm.title
        
    }
}

private extension HeaderCollectionViewCell {
    
    func configureSubviews() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([contentView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
}
