import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON
import ProfileTableViewController
import CustomDropDown

class LoginService {
    
    static func makeLoginValidatityAPIcall(for user : UserCredentials) -> Promise<UserCredentialsResponse> {
        return Promise { seal in
            guard let email = user.email,
                  let password = user.password,
                  email.isValidEmailAddress()
            else {
                let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid user email or password"])
                seal.reject(error)
                return
            }
            let parameters : [String : String] = ["email" : email,  "password" : password]
            var responseC = UserCredentialsResponse()
            AF.request("https://reqres.in/api/login", method: .post, parameters: parameters)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success :
                        responseC.isSuccess = true
                        responseC.accessToken = ""
                        seal.fulfill(responseC)
                    case .failure (let error) :
                        seal.reject(error)
                        
                    }
                }
        }
    }
    
    static func getProfileDetails() -> Promise<ProfileInformationModelResponse> {
        return Promise<ProfileInformationModelResponse> { seal in
            AF.request("https://randomuser.me/api/?exc=login,dob,registered,gender,nat,cell,timezone&noinfo")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["results"].arrayValue
                        
                        if let profileInfo = ProfileInformationModel(json: JSON(rawValue: result[0]) ?? nil) as? ProfileInformationModel,
                           let username = profileInfo.id?.name,
                           let userId = profileInfo.id?.value,
                           !username.isEmpty && !userId.isEmpty {
                            seal.fulfill(ProfileInformationModelResponse(profileInformation: profileInfo, isSuccess: true))
                        } else {
                            seal.reject(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve data at this time, please try again after sometime"]))
                        }
                    case .failure(let error):
                        print(error)
                        seal.reject(error)
                    }
                }
        }
    }
    
    static func getAllStates() -> Promise<StateModelResponse> {
        return Promise<StateModelResponse> { seal in
            AF.request("https://datausa.io/api/data?drilldowns=State&measures=Population&limit=5")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["data"].arrayValue
                        var stateArray = [StateModel]()
                        for stateInfo in result {
                            let state = StateModel(json: stateInfo)
                            stateArray.append(state)
                        }
                        if stateArray.count == 0 {
                            seal.reject(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid state info"]))
                            return
                        }
                        seal.fulfill(StateModelResponse(statesArray: stateArray, isSucess: true))
                    case .failure(let error):
                        print(error)
                        seal.reject(error)
                        
                    }
                }
        }
    }
}
