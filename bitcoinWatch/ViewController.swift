//
//  ViewController.swift
//  bitcoinWatch
//
//  Created by Izloop on 7/8/19.
//  Copyright © 2019 Peter Levi Hornig. All rights reserved.
//

import UIKit
import FLAnimatedImage
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currencySymbol = ""
    
    let gifs = ["bitcoin"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitcoinData(url: finalURL)
        currencySymbol = symbolArray[row]
    }
    
    @IBOutlet var image1: FLAnimatedImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let path1 : String = Bundle.main.path(forResource: "bitcoin", ofType: "gif")!
        let imageData1 = try? FLAnimatedImage(animatedGIFData: Data(contentsOf: URL(fileURLWithPath: path1)))
        image1.animatedImage = imageData1
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinData(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Sucess! Got the bitcoin data")
                let bitcoinJSON : JSON = JSON(response.result.value!)
                
                self.updateBitcoinData(json: bitcoinJSON)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.priceLabel.text = "ntx error"
                
                
            }
        }
        
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinData(json : JSON) {
        
        if let currencyResult = json["ask"].double {
            priceLabel.text = currencySymbol + String(currencyResult)
            
        } else {
            priceLabel.text = "error"
        }
        
    }

}

