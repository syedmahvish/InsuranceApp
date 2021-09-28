import Foundation
import ProfileTableViewController
import CustomDropDown

protocol PoliciesTableViewControllerConfigurable {
    var navigationTitle: String { get }
    var numberOfSections: Int { get }
    
    func numberOfRowsPerSection(section: Int) -> Int
    func row(for indexPath: IndexPath) -> PoliciesRow?
    func title(section: Int) -> String
}

class PoliciesTableViewControllerViewModel : PoliciesTableViewControllerConfigurable {
    private var dataProvider: PoliciesDataProviderConfigurable?
    var sections = [PoliciesSection]()
    var profileInformation : ProfileInformationModel?
    var stateDropDownArray : [StateModel]?
    
    public init(profileInformation : ProfileInformationModel? = nil, stateDropDownArray : [StateModel]? = nil, dataProvider : PoliciesDataProviderConfigurable? = PoliciesDataProvider.sharedInstance) {
        self.dataProvider = dataProvider
        self.profileInformation = profileInformation
        self.stateDropDownArray = stateDropDownArray
        setupSections()
    }
    
    func setupSections() {
        let policiesData = dataProvider?.loadPoliciesData()
        var rows = [PoliciesRow]()
        
        if let autoRenwalsArray = policiesData?.autoRenewalsModelArray {
            for autoRenewalModel in autoRenwalsArray {
                rows.append(PoliciesRow.autoRenewalTableViewCell(AutoRenewalInfoViewModel(autoRenewalModel: autoRenewalModel)))
            }
        }
        sections.append(.autoRenewalSection(rows))
        
        rows = [PoliciesRow]()
        if let homeRental = policiesData?.homeRentalModel {
            rows.append(PoliciesRow.homeRentalTableViewCell(HomeRentalViewModel(homeRentalInfo: homeRental)))
        }
        sections.append(.homeRentalSection(rows))
        
        rows = [PoliciesRow]()
        if let reportAndRequestArray = policiesData?.reportAndRentalModelsArray {
            for reportAndRequestModel in reportAndRequestArray {
                rows.append(PoliciesRow.reportAndRequestTableViewCell(ReportAndRequestTableViewCellViewModel(reportAndRequestModel: reportAndRequestModel)))
            }
        }
        sections.append(.reportAndRequestSection(rows))
    }
}

extension PoliciesTableViewControllerViewModel {
    var navigationTitle : String {
        "POLICIES"
    }

    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfRowsPerSection(section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    func row(for indexPath: IndexPath) -> PoliciesRow? {
        return sections[indexPath.section].row(for: indexPath)
    }
    
    func title(section: Int) -> String {
        return sections[section].title()
    }
}

enum PoliciesRow {
    case autoRenewalTableViewCell(AutoRenewalInfoConfigurable)
    case homeRentalTableViewCell(HomeRentalTableViewCellConfigurable)
    case reportAndRequestTableViewCell(ReportAndRequestTableViewCellConfigurable)
}

enum PoliciesSection {
    case autoRenewalSection([PoliciesRow])
    case homeRentalSection([PoliciesRow])
    case reportAndRequestSection([PoliciesRow])
    
    func numberOfRows() -> Int {
        switch self {
        case let .autoRenewalSection(contactAgentRows):
            return contactAgentRows.count
        case let .homeRentalSection(homeRentalRows):
            return homeRentalRows.count
        case let .reportAndRequestSection(reportAndRequestRows):
            return reportAndRequestRows.count
        }
    }
    
    func row(for indexPath: IndexPath) -> PoliciesRow? {
        switch self {
        case let .autoRenewalSection(contactAgentRows):
            return contactAgentRows[indexPath.row]
        case let .homeRentalSection(homeRentalRows):
            return homeRentalRows[indexPath.row]
        case let .reportAndRequestSection(reportAndRequestRows):
            return reportAndRequestRows[indexPath.row]
        }
    }
    
    func title() -> String {
        switch self {
        case let .autoRenewalSection(contactAgentRows):
            return "AUTO"
        case let .homeRentalSection(homeRentalRows):
            return "HOME/RENTAL"
        case let .reportAndRequestSection(reportAndRequestRows):
            return "DOCUMENTS"
        }
    }
}
