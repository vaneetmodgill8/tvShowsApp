//
//  Utility+NSObject.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

