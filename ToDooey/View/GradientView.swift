//
//  GradientView.swift
//  ToDooey
//
//  Created by Rick on 4/23/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit

extension UIView {

    func setGradientBackground() -> UIView {
        let gradientView = UIView()
        gradientView.frame = UIScreen.main.bounds
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = gradientView.bounds
        
        gradientView.layer.addSublayer(gradientLayer)
        return gradientView
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

}
