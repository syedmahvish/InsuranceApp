import Foundation
import ProfileTableViewController
import CustomDropDown
import Generics

protocol DashboardTableViewControllerConfigurable {
    var navigationTitle : String { get }
    var numberOfSections : Int { get }
    
    func numberOfRows(for section : Int) -> Int
    func titleForSection(for section : Int) -> String
    func rows(for indexPath : IndexPath) -> DashBoardRows?
    func heightForRows(for indexPath : IndexPath) -> CGFloat
}

class DashboardTableViewControllerViewModel : DashboardTableViewControllerConfigurable {
    
    private var dataProvider: DashBoardDataProviderConfigurable?
    var sections = [DashboardSections]()
    var profileInformation : ProfileInformationModel?
    var stateDropDownArray : [StateModel]?
    
    public init(profileInformation : ProfileInformationModel? = nil, stateDropDownArray : [StateModel]? = nil, dataProvider : DashBoardDataProviderConfigurable? = DashBoardDataProvider.sharedInstance) {
        self.dataProvider = dataProvider
        self.profileInformation = profileInformation
        self.stateDropDownArray = stateDropDownArray
        setupSections()
    }
    
    func setupSections() {
        let dashBoardData = dataProvider?.loadDashboardData()
        
        var rows = [DashBoardRows]()
        if let billsInfo = dashBoardData?.upcomingBillsModel {
            rows.append(DashBoardRows.billsInfoRows(UpcomingBillsTableViewCellViewModel(upcomingBillsModel: billsInfo)))
        }
        sections.append(.billsSection(rows))
        
        rows = [DashBoardRows]()
        if let idsInfo = dashBoardData?.idsModel {
            rows.append(DashBoardRows.idsInfoRows(IdsTableViewCellViewModel(idsModelArray: idsInfo)))
        }
        sections.append(.idsSection(rows))
        
        rows = [DashBoardRows]()
        if let reportAndRequestArray = dashBoardData?.reportAndRentalModelsArray {
            for reportAndRequestModel in reportAndRequestArray {
                rows.append(DashBoardRows.reportAndRequestTableViewCell(ReportAndRequestTableViewCellViewModel(reportAndRequestModel: reportAndRequestModel)))
            }
        }
        sections.append(.reportAndRequestSection(rows))
        
        rows = [DashBoardRows]()
        rows.append(DashBoardRows.contactTableViewCell(ContactAgentTableViewCellViewModel(profileInformationModel: profileInformation ?? ProfileInformationModel(json: nil))))
        sections.append(.contactSection(rows))
    }
}

extension DashboardTableViewControllerViewModel {
    var numberOfSections: Int {
        sections.count
    }
    
    var navigationTitle : String {
        TitleConstant.dashboardTitle.rawValue
    }
    
    func numberOfRows(for section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    func titleForSection(for section: Int) -> String {
        return sections[section].title()
    }
    
    func rows(for indexPath: IndexPath) -> DashBoardRows? {
        return sections[indexPath.section].row(for: indexPath)
    }
    
    func heightForRows(for indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].heightForRows(for: indexPath)
    }
}

enum DashBoardRows {
    case billsInfoRows(UpcomingBillsTableViewCellConfigurable)
    case idsInfoRows(IdsTableViewCellConfigurable)
    case reportAndRequestTableViewCell(ReportAndRequestTableViewCellConfigurable)
    case contactTableViewCell(ContactAgentTableViewCellConfigurable)
}

enum DashboardSections {
    case billsSection([DashBoardRows])
    case idsSection([DashBoardRows])
    case reportAndRequestSection([DashBoardRows])
    case contactSection([DashBoardRows])
    
    func numberOfRows() -> Int {
        switch self {
        case let .billsSection(billsRow):
            return billsRow.count
        case let .idsSection(idsRows):
            return idsRows.count
        case let .reportAndRequestSection(reportAndRequestRows):
            return reportAndRequestRows.count
        case let .contactSection(profileInfoRows):
            return profileInfoRows.count
        }
    }
    
    func row(for indexPath: IndexPath) -> DashBoardRows? {
        switch self {
        case let .billsSection(billsRow):
            return billsRow[indexPath.row]
        case let .idsSection(idsRows):
            return idsRows[indexPath.row]
        case let .reportAndRequestSection(reportAndRequestRows):
            return reportAndRequestRows[indexPath.row]
        case let .contactSection(profileInfoRows):
            return profileInfoRows[indexPath.row]
        }
    }
    
    func title() -> String {
        switch self {
        case .billsSection(_):
            return "Upcoming Bills"
        case .idsSection(_):
            return "My IDs"
        case .reportAndRequestSection(_):
            return "Report/Request"
        case .contactSection(_):
            return "Contact Agent"
        }
    }
    
    func heightForRows(for indexPath: IndexPath) -> CGFloat {
        switch self {
        case .billsSection(_):
            return UITableView.automaticDimension
        case let .idsSection(idsRows):
            return 200
        case .reportAndRequestSection(_):
            return UITableView.automaticDimension
        case .contactSection(_):
            return UITableView.automaticDimension
        }
    }
}
