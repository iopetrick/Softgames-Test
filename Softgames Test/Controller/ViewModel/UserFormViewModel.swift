//
//  UserFormViewModel.swift
//  Softgames Test
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import Foundation

protocol UserFormViewModelDelegate: AnyObject {
    func showError(message: String)
    func sendFullName(fullName: String)
    func sendUserAge(age: String)
}

class UserFormViewModel {
    
    let webkitInterfaceName = "softgame_web_interface_fullname"
    let webkitInterfacedob = "softgame_web_interface_dob"
    let webkitInterfaceNotification = "softgame_web_interface_notification"
    
    private let errorMessageFullname: String = "First and last name is mendatory. Please input missing values."
    private let errorMessageDob: String = "Invalid Date of birth. Please add valid date."
    
    weak var delegate: UserFormViewModelDelegate?
    
    init(delegate: UserFormViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func getDataFrom(dictionary: [String: String?]?) {
        guard let data = dictionary else { return }
        let firstName = data["first_name"] as? String ?? ""
        let lastName = data["last_name"] as? String ?? ""
        if !firstName.isEmpty && !lastName.isEmpty {
            self.delegate?.sendFullName(fullName: firstName + " " + lastName)
        } else {
            self.delegate?.showError(message: errorMessageFullname)
        }
    }
    
    private func calculate(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        guard let birthdayDate = dateFormater.date(from: birthday) else { return -1 }
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let result = calendar.components(.year, from: birthdayDate, to: Date(), options: [])
        return result.year ?? -1
    }
    
    func showUserAge(date: String) {
        if date.isEmpty {
            self.delegate?.showError(message: errorMessageDob)
            return
        }
        let age = self.calculate(birthday: date)
        if age >= 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.delegate?.sendUserAge(age: age.description)
            }
        } else {
            // Show Error
            self.delegate?.showError(message: errorMessageDob)
        }
    }
    
    func triggerLocalNotification() {
        debugPrint(#function)
        NotificationManager.shared.scheduleNotification()
    }
}
