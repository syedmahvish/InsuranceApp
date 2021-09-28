import Foundation

struct QuoteRequestPopupModel {
    var quoteUpdatePaymentMethod : [QuoteUpdatePaymentMethod]?
    var quoteMakePayment : [QuoteMakePayment]?
    var quoteSchedulePayment : [QuoteSchedulePayment]?
}

struct QuoteBillPaymentModel {
    var amount : String?
    var amountSubText : String?
    var categoryTypeText : String?
    var categoryType : String?
    var message : String?
}

struct QuoteUpdatePaymentMethod {
    var cardName :String?
    var cardNumber :String?
}

struct QuoteMakePayment {
    var paymentTypeName : String?
}

struct QuoteSchedulePayment {
    var scheduleType : String?
    var scheduleDetail : String?
    var actionName : String?
}

struct SectionHeaderModel {
    var title : String?
    var image : String?
    var isHidden : Bool = true
    var index : Int?
}

struct ChangePaymentPlanModel {
    var selectPaymentPlanModelArray : [SelectPaymentPlanModel]?
    var schedulePaymentPlanModelArray : [SchedulePaymentPlanModel]?
}

struct SelectPaymentPlanModel {
    var name : String?
    var isSelected : Bool = false
}

struct SchedulePaymentPlanModel {
    var date : String?
    var amount : String?
}



