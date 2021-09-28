import Foundation

protocol PoliciesDataProviderConfigurable {
    var policiesDataModel : PoliciesDataModel? {get}
    func loadPoliciesData() -> PoliciesDataModel?
}

class PoliciesDataProvider :  PoliciesDataProviderConfigurable {
    public static let sharedInstance = PoliciesDataProvider()
    var policiesDataModel : PoliciesDataModel?
    
    func loadPoliciesData() -> PoliciesDataModel? {
        var autoRenewalInformationModelArray = [AutoRenewalInformationModel]()
        autoRenewalInformationModelArray.append(AutoRenewalInformationModel(name: "2017 RAV 4", upcomingBillingDate: "08/27/2021", billImage: "noBillsImage"))
        autoRenewalInformationModelArray.append(AutoRenewalInformationModel(name: "2019 HONDA CRV", upcomingBillingDate: "10/13/2022", billImage: "noBillsImage"))
        var homeRental = HomeRentalModel(name: "7000 Christopher Wendrive", type: "Rental", policyEndDate: "09/13/2021")
        var reportAndRequestModelArray = [ReportAndRequestModel]()
        reportAndRequestModelArray.append(ReportAndRequestModel(title: "Auto"))
        reportAndRequestModelArray.append(ReportAndRequestModel(title: "Life"))
        reportAndRequestModelArray.append(ReportAndRequestModel(title: "House"))
        
        policiesDataModel = PoliciesDataModel(autoRenewalsModelArray: autoRenewalInformationModelArray, homeRentalModel: homeRental, reportAndRentalModelsArray: reportAndRequestModelArray)
        
        return policiesDataModel
    }
}
