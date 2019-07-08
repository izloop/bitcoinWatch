//
//  ViewController.swift
//  bitcoinWatch
//
//  Created by Izloop on 7/8/19.
//  Copyright © 2019 Peter Levi Hornig. All rights reserved.
//

import UIKit
import FLAnimatedImage

class ViewController: UIViewController {
    
    let gifs = ["bitcoin"]
    
    @IBOutlet var image1: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let path1 : String = Bundle.main.path(forResource: "bitcoin", ofType: "gif")!
        let imageData1 = try? FLAnimatedImage(animatedGIFData: Data(contentsOf: URL(fileURLWithPath: path1)))
        image1.animatedImage = imageData1
    }

    

}

