import Foundation
import ProfileTableViewController
import CustomDropDown

protocol ChangePaymentPlanTableViewConfigurable {
    var navigationTitle: String? { get }
    var numberOfSections: Int { get }
    
    func numberOfRowsPerSection(section: Int) -> Int
    func row(for indexPath: IndexPath) -> ChangePaymentPlanRow?
    func title(section: Int) -> String
}

class ChangePaymentPlanTableViewViewModel :  ChangePaymentPlanTableViewConfigurable {
    var sections = [ChangePaymentPlanSection]()
    private var dataProvider: QuoteRequestDataProvider?
    var profileInformation : ProfileInformationModel?
    var stateDropDownArray : [StateModel]?
    
    public init(profileInformation : ProfileInformationModel? = nil, stateDropDownArray : [StateModel]? = nil, dataProvider : QuoteRequestDataProvider? = QuoteRequestDataProvider.sharedInstance) {
        self.dataProvider = dataProvider
        self.profileInformation = profileInformation
        self.stateDropDownArray = stateDropDownArray
        setupSections()
    }
    
    func setupSections() {
        let changePaymentPlanData = dataProvider?.loadChangePaymentPlanData()
        
        var rows = [ChangePaymentPlanRow]()
        if let selectPaymentPlanArray = changePaymentPlanData?.selectPaymentPlanModelArray {
            for paymentPlan in selectPaymentPlanArray {
                rows.append(ChangePaymentPlanRow.selectPaymentRows(SelectPaymnetPlanTableViewCellViewModel(selectPaymentPlanModel: paymentPlan)))
            }
        }
        sections.append(.selectPaymentSection(rows))
        
        rows = [ChangePaymentPlanRow]()
        if let schedulePaymentPlanArray = changePaymentPlanData?.schedulePaymentPlanModelArray {
            for schedulePlan in schedulePaymentPlanArray {
                rows.append(ChangePaymentPlanRow.schedulePaymentRows(SchedulePaymentTableViewCellViewModel(schedulePaymentPlanModel: schedulePlan)))
            }
        }
        sections.append(.schedulePaymentSection(rows))
    }
    
    func updateSections(for selectedIndex : Int) {
        let changePaymentPlanData = dataProvider?.updateSelectedPaymentPlan(for: selectedIndex)
        sections = [ChangePaymentPlanSection]()
        
        var rows = [ChangePaymentPlanRow]()
        if let selectPaymentPlanArray = changePaymentPlanData?.selectPaymentPlanModelArray {
            for paymentPlan in selectPaymentPlanArray {
                rows.append(ChangePaymentPlanRow.selectPaymentRows(SelectPaymnetPlanTableViewCellViewModel(selectPaymentPlanModel: paymentPlan)))
            }
        }
        sections.append(.selectPaymentSection(rows))
        
        rows = [ChangePaymentPlanRow]()
        if let schedulePaymentPlanArray = changePaymentPlanData?.schedulePaymentPlanModelArray {
            for schedulePlan in schedulePaymentPlanArray {
                rows.append(ChangePaymentPlanRow.schedulePaymentRows(SchedulePaymentTableViewCellViewModel(schedulePaymentPlanModel: schedulePlan)))
            }
        }
        sections.append(.schedulePaymentSection(rows))
    }
}

extension ChangePaymentPlanTableViewViewModel {
    var navigationTitle: String? {
        return "Change Payment Plan"
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRowsPerSection(section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    func title(section: Int) -> String {
        return sections[section].title()
    }
    
    func row(for indexPath: IndexPath) -> ChangePaymentPlanRow? {
        return sections[indexPath.section].row(for: indexPath)
    }
}

enum ChangePaymentPlanRow {
    case selectPaymentRows(SelectPaymnetPlanTableViewCellConfigurable)
    case schedulePaymentRows(SchedulePaymentTableViewCellConfigurable)
}

enum ChangePaymentPlanSection {
    case selectPaymentSection([ChangePaymentPlanRow])
    case schedulePaymentSection([ChangePaymentPlanRow])
    
    func numberOfRows() -> Int {
        switch self {
        case let .selectPaymentSection(selectPaymentRows):
            return selectPaymentRows.count
        case let .schedulePaymentSection(schedulePaymentRows):
            return schedulePaymentRows.count
        }
    }
    
    func row(for indexPath: IndexPath) -> ChangePaymentPlanRow? {
        switch self {
        case let .selectPaymentSection(selectPaymentRows):
            return selectPaymentRows[indexPath.row]
        case let .schedulePaymentSection(schedulePaymentRows):
            return schedulePaymentRows[indexPath.row]
        }
    }
    
    func title() -> String {
        switch self {
        case .selectPaymentSection(_):
            return "Select a New Payment Plan"
        case .schedulePaymentSection(_):
            return "Schedule Payments"
        }
    }
}


