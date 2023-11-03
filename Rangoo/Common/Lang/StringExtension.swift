//
//  StringExtension.swift
//  Rangoo
//
//  Created by coltec on 13/06/23.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func isPhoneNumber() -> Bool {
        return self.count > 9 && self.count < 12
    }
    
    func isDate() -> Bool {
        return self.count == 10
    }
    
    func isPassword() -> Bool {
        guard self.count == 8 else {
            return false
        }
    
        // Verifica se contém pelo menos uma letra maiúscula e um número
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let numberRegex = ".*[0-9]+.*"
    
        let uppercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return uppercaseLetterPredicate.evaluate(with: self) && numberPredicate.evaluate(with: self)
    }
    
    func toDate (sourcePattern source: String, destPattern dest : String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}
