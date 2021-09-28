import Foundation

extension String {
    
    public func isValidString() -> Bool {
        if self.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    public func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public func isValidUsername() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{7,18}$", options: .caseInsensitive)
            if regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0 {
                return true
            }
        } catch {
            print("Invalid User name")
        }
        return false
    }
    
    public func isValidPassword() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8}$", options: .caseInsensitive)
            if regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0 {
                return true
            }
        } catch {
            print("Invalid User name")
        }
        return false
    }
}
