import Foundation
import Generics

public struct ProfileInformationViewModel {
    var labelTitle : String
    var textFieldValue : String
    
    static func getProfileInformationArray(profileInformation : ProfileInformationModel?) -> [ProfileInformationViewModel] {
        var profileInfoArray = [ProfileInformationViewModel]()
        guard let profileInformation = profileInformation else { return profileInfoArray }
        
        var profileInfo = ProfileInformationViewModel(labelTitle: "Street", textFieldValue: profileInformation.location?.street?.name ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "Apt/Suite", textFieldValue: profileInformation.location?.street?.number ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "City", textFieldValue: profileInformation.location?.city ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "State", textFieldValue: profileInformation.location?.state ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "Country", textFieldValue: profileInformation.location?.country ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "Zip", textFieldValue: profileInformation.location?.postcode ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "Phone", textFieldValue: profileInformation.phone ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        profileInfo = ProfileInformationViewModel(labelTitle: "Email", textFieldValue: profileInformation.email ?? EmptyTextConstant.emptyTextValue.rawValue)
        profileInfoArray.append(profileInfo)
        return profileInfoArray
    }
}
