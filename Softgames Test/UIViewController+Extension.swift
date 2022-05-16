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
    
    func showAppSettingAlert() {
        let alertController = UIAlertController.init(title: "Warning", message: "Please allow local notification access.", preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        let setting = UIAlertAction.init(title: "Setting", style: .default) { (alert) in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(setting)
        self.present(alertController, animated: true)
    }
}
