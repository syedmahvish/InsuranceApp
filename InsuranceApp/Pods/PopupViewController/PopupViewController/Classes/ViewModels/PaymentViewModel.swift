import Foundation

public struct PaymentModel {
    var imageString : String?
    var nameLabelString : String?
    var duePaymentString : String?
    var buttonTitle : String?
    var viewTitle : String?
    
    public init(imageString : String, nameLabelString : String, duePaymentString : String, buttonTitle : String, viewTitle : String) {
        self.imageString = imageString
        self.nameLabelString = "Bill Name: \(nameLabelString)"
        self.duePaymentString = "Due Billing Payment Amount: $\(duePaymentString)"
        self.buttonTitle = buttonTitle
        self.viewTitle = viewTitle
    }
}

public protocol PaymentViewModelConfigurable {
    var paymentModel : PaymentModel? {get}
}

public class PaymentViewModel : PaymentViewModelConfigurable {
    public var paymentModel : PaymentModel?
    
    public init(paymentModel : PaymentModel) {
        self.paymentModel = paymentModel
    }
}
