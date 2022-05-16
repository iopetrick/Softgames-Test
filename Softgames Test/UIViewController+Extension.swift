//
//  UIViewController+Extension.swift
//  Softgames Test
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = "Warning", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertActionOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alertVC.addAction(alertActionOk)
        self.present(alertVC, animated: true)
    }
    
}
