import Foundation
import Generics

public protocol AutoRenewalInfoConfigurable {
    var autoRenewalModel: AutoRenewalInformationModel? { get }
}

public class AutoRenewalInfoViewModel :  AutoRenewalInfoConfigurable {
    public var autoRenewalModel: AutoRenewalInformationModel?
    
    init(autoRenewalModel: AutoRenewalInformationModel?) {
        self.autoRenewalModel = autoRenewalModel
        configureInformation()
    }
    
    private func configureInformation() {
        guard let infoModel = autoRenewalModel else {
            return
        }
        autoRenewalModel?.name = infoModel.name ?? EmptyTextConstant.emptyTextValue.rawValue
        autoRenewalModel?.upcomingBillingDate = "Next Billing Date: " + (infoModel.upcomingBillingDate ?? EmptyTextConstant.emptyTextValue.rawValue)
        autoRenewalModel?.billImage = infoModel.billImage ?? ImageString.defaultProfilePicture.rawValue
    }
}
