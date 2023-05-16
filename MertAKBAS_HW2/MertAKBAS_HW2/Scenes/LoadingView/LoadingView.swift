//
//  LoadingView.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 12.05.2023.
//

import UIKit

class LoadingView {
    var timer: Bool = false
    var acrivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        acrivityIndicator.center = blurView.center
        acrivityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            acrivityIndicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        blurView.contentView.addSubview(acrivityIndicator)
    }
    
    func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        acrivityIndicator.startAnimating()
//        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
//            print("timer çalıştı")
//            self.hideLoading()
//        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.blurView.removeFromSuperview()
            self.acrivityIndicator.stopAnimating()
        }
        
    }
}

