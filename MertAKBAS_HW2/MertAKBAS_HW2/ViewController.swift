//
//  ViewController.swift
//  MertAKBAS_HW2
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import UIKit
import MertAKBAS_HW2API

class ViewController: UIViewController {

    let service: PopularNewsServiceProtocol = PopularNewsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        service.fetchPopularNews { response in
            switch response {
            case .success(let data):
                print("mert: \(data)")
            case .failure(let error):
                print("mert: \(error)")
            }
        }
    }
}

