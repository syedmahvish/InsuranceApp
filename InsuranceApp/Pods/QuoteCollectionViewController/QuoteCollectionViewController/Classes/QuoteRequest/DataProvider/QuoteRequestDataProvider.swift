import Foundation

protocol QuoteRequestDataProviderConfigurable {
    var quoteRequestPopupModel : QuoteRequestPopupModel? { get }
    func loadQuoteRequestData() -> QuoteRequestPopupModel?
}

class QuoteRequestDataProvider : QuoteRequestDataProviderConfigurable {
    public static let sharedInstance = QuoteRequestDataProvider()
    var quoteRequestPopupModel: QuoteRequestPopupModel?
    
    func loadQuoteRequestData() -> QuoteRequestPopupModel? {
        var quoteUpdatePaymentMethodArray = [QuoteUpdatePaymentMethod]()
        quoteUpdatePaymentMethodArray.append(QuoteUpdatePaymentMethod(cardName: "VISA", cardNumber: "***-5152"))
        quoteUpdatePaymentMethodArray.append(QuoteUpdatePaymentMethod(cardName: "DISCOVER", cardNumber: "***-2345"))
        
        var quoteMakePaymentArray = [QuoteMakePayment]()
        quoteMakePaymentArray.append(QuoteMakePayment(paymentTypeName: "PayPal"))
        quoteMakePaymentArray.append(QuoteMakePayment(paymentTypeName: "Western Union"))
        quoteMakePaymentArray.append(QuoteMakePayment(paymentTypeName: "Wire Transfer"))
        
        var quoteSchedulePaymentArray = [QuoteSchedulePayment]()
        quoteSchedulePaymentArray.append(QuoteSchedulePayment(scheduleType: "Billing Schedule", scheduleDetail: "Payment Schedule", actionName: "View"))
        quoteSchedulePaymentArray.append(QuoteSchedulePayment(scheduleType: " Current Payment Plan", scheduleDetail: "6p TMPP", actionName: "Edit"))
        quoteSchedulePaymentArray.append(QuoteSchedulePayment(scheduleType: " Paperless Billing", scheduleDetail: "Enroll", actionName: "Edit"))
        
        quoteRequestPopupModel = QuoteRequestPopupModel(quoteUpdatePaymentMethod: quoteUpdatePaymentMethodArray, quoteMakePayment: quoteMakePaymentArray, quoteSchedulePayment: quoteSchedulePaymentArray)
        return quoteRequestPopupModel
    }
    
    func loadBillData() -> QuoteBillPaymentModel {
        return QuoteBillPaymentModel(amount: nil, amountSubText: "Withdrawal Amount", categoryTypeText: "Category Type", categoryType: nil, message: "This Payment is not eligible to postpone.")
    }
    
    func loadChangePaymentPlanData() -> ChangePaymentPlanModel {
        var selectPaymentPlanModelArray = [SelectPaymentPlanModel]()
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "Pay in full", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "2 Payments - 50% Down Payments", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "3 Payments - 40% Down Payments", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "4 Payments - 25% Down Payments", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "5 Payments - 20% Down Payments", isSelected: true))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "5 Payments - 25% Down Payments", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "5 Payments - 33% Down Payments", isSelected: false))
        selectPaymentPlanModelArray.append(SelectPaymentPlanModel(name: "Truly Montly", isSelected: false))
        
        var schedulePaymentPlanModelArray = [SchedulePaymentPlanModel]()
        schedulePaymentPlanModelArray.append(SchedulePaymentPlanModel(date: "October 13, 2021", amount: "$219.99"))
        schedulePaymentPlanModelArray.append(SchedulePaymentPlanModel(date: "November 13, 2021", amount: "$153.99"))
        schedulePaymentPlanModelArray.append(SchedulePaymentPlanModel(date: "December 13, 2021", amount: "$153.00"))
        schedulePaymentPlanModelArray.append(SchedulePaymentPlanModel(date: "January 13, 2021", amount: "$153.00"))
        
        return ChangePaymentPlanModel(selectPaymentPlanModelArray: selectPaymentPlanModelArray, schedulePaymentPlanModelArray: schedulePaymentPlanModelArray)
    }
    
    func updateSelectedPaymentPlan(for selectedIndex : Int) -> ChangePaymentPlanModel {
        let changePaymentPlanData = QuoteRequestDataProvider.sharedInstance.loadChangePaymentPlanData()
        guard let selectPaymentPlanArray = changePaymentPlanData.selectPaymentPlanModelArray else {
            return ChangePaymentPlanModel(selectPaymentPlanModelArray: nil, schedulePaymentPlanModelArray: nil)
        }
        
        var updatedSelectedPaymentArray = [SelectPaymentPlanModel]()
        var index = 0
        for plan in selectPaymentPlanArray {
            let isSelected = index == selectedIndex ? true : false
            updatedSelectedPaymentArray.append(SelectPaymentPlanModel(name: plan.name, isSelected: isSelected))
            index += 1
        }
        return ChangePaymentPlanModel(selectPaymentPlanModelArray: updatedSelectedPaymentArray, schedulePaymentPlanModelArray: changePaymentPlanData.schedulePaymentPlanModelArray)
    }
}
