import Foundation
import UIKit

struct UserCredentials {
    var email : String? //= "eve.holt@reqres.in"
    var password : String? //= "cityslicka"
}

struct UserCredentialsResponse {
    var isSuccess : Bool = false
    var accessToken : String?
}
