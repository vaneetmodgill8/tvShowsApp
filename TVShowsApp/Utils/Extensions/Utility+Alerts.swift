//
//  Utility+Alerts.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//
import UIKit


extension UIViewController {
    func showAlertForErrors(message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
