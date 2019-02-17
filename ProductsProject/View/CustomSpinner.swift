//
//  CustomSpinner.swift
//  ProductsProject
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit



// USED TO START AND STOP SPINNER ANIMATION BEFORE AND AFTER API REQUESTS
public class Spinner{
    
    let loadingTextLabel = UILabel()
    let spinner = UIActivityIndicatorView()
    var customView = UIView()
    
    
    
    func startLoading(viewOfScroll: UIView, message: String = ""){
        
        spinner.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        spinner.style = .whiteLarge
        spinner.color = UIColor.gray
        spinner.backgroundColor = UIColor.clear
        spinner.center = CGPoint(x: viewOfScroll.frame.size.width / 2 , y: viewOfScroll.frame.size.height / 2)
        
        
        customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: viewOfScroll.bounds.height))
        customView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        
        loadingTextLabel.textColor = UIColor.white
        loadingTextLabel.text = message
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 22)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: spinner.center.x, y: spinner.center.y + 30)
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        customView.addSubview(loadingTextLabel)
        customView.addSubview(spinner)
        
        viewOfScroll.addSubview(customView)
        viewOfScroll.isUserInteractionEnabled = false
    }
    
    
    func stopLoading(viewOfScroll: UIView){
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
            
            self.customView.removeFromSuperview()
            viewOfScroll.isUserInteractionEnabled = true
        }
        
    }
}

