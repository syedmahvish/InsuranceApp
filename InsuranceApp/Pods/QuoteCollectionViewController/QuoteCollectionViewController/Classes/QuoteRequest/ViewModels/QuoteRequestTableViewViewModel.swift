import Foundation
import ProfileTableViewController
import CustomDropDown

protocol  QuoteRequestTableViewConfigurable {
    var navigationTitle: String { get }
    var numberOfSections: Int { get }
    
    func numberOfRowsPerSection(section: Int) -> Int
    func row(for indexPath: IndexPath) -> QuoteRequestRow?
    func sectionHeader(section: Int) -> SectionHeaderModel?
}

class QuoteRequestTableViewViewModel : QuoteRequestTableViewConfigurable {
    private var dataProvider: QuoteRequestDataProviderConfigurable?
    var sections = [QuoteRequestSection]()
    var sectionHeaderArray : [SectionHeaderModel]?
    var quoteBillPaymentModel : QuoteBillPaymentModel?
    
    public init(dataProvider : QuoteRequestDataProviderConfigurable? = QuoteRequestDataProvider.sharedInstance) {
        self.dataProvider = dataProvider
        setupSections()
    }
    
    func setupSections() {
        let quoteRequestData = dataProvider?.loadQuoteRequestData()
        var rows = [QuoteRequestRow]()
        
        if let updatePaymentMethodArray = quoteRequestData?.quoteUpdatePaymentMethod {
            for updatePaymentMethod in updatePaymentMethodArray {
                rows.append(QuoteRequestRow.updatePaymentMethod(QuoteUpdatePaymentMethodViewModel(quoteUpdatePaymentMethod: updatePaymentMethod)))
            }
        }
        sections.append(.updatePaymentMethodSection(rows))
        
        rows = [QuoteRequestRow]()
        if let quoteMakePaymentArray = quoteRequestData?.quoteMakePayment {
            for quoteMakePayment in quoteMakePaymentArray {
                rows.append(QuoteRequestRow.makePayment(QuoteMakePaymentViewModel(quoteMakePayment: quoteMakePayment)))
            }
        }
        sections.append(.makePaymentSection(rows))
        
        rows = [QuoteRequestRow]()
        if let quoteSchedulePaymentArray = quoteRequestData?.quoteSchedulePayment {
            for quoteSchedulePayment in quoteSchedulePaymentArray {
                rows.append(QuoteRequestRow.schedulePayment(QuoteSchedulePaymentViewModel(quoteSchedulePayment: quoteSchedulePayment)))
            }
        }
        sections.append(.schedulePaymentSection(rows))
        
        sectionHeaderArray = [SectionHeaderModel]()
        sectionHeaderArray?.append(SectionHeaderModel(title: "Update Payment Methods", image: "folder.circle" , index: 0))
        sectionHeaderArray?.append(SectionHeaderModel(title: "Make a Payment", image: "calendar.circle" , index: 1))
        sectionHeaderArray?.append(SectionHeaderModel(title: "Payment Plan, Billing Schedule and Paperless Billing", image: "calendar.circle" , index: 2))
    }
}

extension QuoteRequestTableViewViewModel {
    var navigationTitle : String {
        "Manage My Bills"
    }
    
    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfRowsPerSection(section: Int) -> Int {
        guard let sectionHeader = sectionHeaderArray?[section] else {
            return sections[section].numberOfRows()
        }
        return sectionHeader.isHidden ? 0 : sections[section].numberOfRows()
    }
    
    func row(for indexPath: IndexPath) -> QuoteRequestRow? {
        return sections[indexPath.section].row(for: indexPath)
    }
    
    func sectionHeader(section: Int) -> SectionHeaderModel? {
        guard let sectionHeader = sectionHeaderArray?[section] else {
            return nil
        }
        return sectionHeader
    }
}

enum QuoteRequestRow {
    case updatePaymentMethod(QuoteUpdatePaymentMethodConfigurable)
    case makePayment(QuoteMakePaymentConfigurable)
    case schedulePayment(QuoteSchedulePaymentConfigurable)
}

enum QuoteRequestSection {
    case updatePaymentMethodSection([QuoteRequestRow])
    case makePaymentSection([QuoteRequestRow])
    case schedulePaymentSection([QuoteRequestRow])
    
    func numberOfRows() -> Int {
        switch self {
        case let .updatePaymentMethodSection(updatePaymentMethodRows):
            return updatePaymentMethodRows.count
        case let .makePaymentSection(makePaymentRows):
            return makePaymentRows.count
        case let .schedulePaymentSection(schedulePaymentRows):
            return schedulePaymentRows.count
}
    }
    
    func row(for indexPath: IndexPath) -> QuoteRequestRow? {
        switch self {
        case let .updatePaymentMethodSection(updatePaymentRows):
            return updatePaymentRows[indexPath.row]
        case let .makePaymentSection(makePaymentRows):
            return makePaymentRows[indexPath.row]
        case let .schedulePaymentSection(schedulePaymentRows):
            return schedulePaymentRows[indexPath.row]
        }
    }
}
