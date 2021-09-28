import Foundation
import UIKit
import ProfileTableViewController
import CustomDropDown

protocol QuotesCollectionViewControllerConfigurable {
    var navigationTitle: String? { get }
    var numberOfSections: Int { get }
    
    func numberOfRowsPerSection(section: Int) -> Int
    func row(for indexPath: IndexPath) -> QuoteRow?
    func title(section: Int) -> String
    func getIdentifier(for cell : ReuseCellIdentifier) -> String
}

class QuotesCollectionViewControllerViewModel : QuotesCollectionViewControllerConfigurable {
    var sections = [QuoteSection]()
    private var dataProvider: QuotesDataProvider?
    var profileInformation : ProfileInformationModel?
    var stateDropDownArray : [StateModel]?
    
    public init(profileInformation : ProfileInformationModel? = nil, stateDropDownArray : [StateModel]? = nil, dataProvider : QuotesDataProvider? = QuotesDataProvider.sharedInstance) {
        self.dataProvider = dataProvider
        self.profileInformation = profileInformation
        self.stateDropDownArray = stateDropDownArray
        setupSections()
    }
    
    func setupSections() {
        let quoteData = dataProvider?.loadData()
        
        var rows = [QuoteRow]()
        if let myQuotes = quoteData?.quoteModel {
            for quote in myQuotes {
                rows.append(QuoteRow.quoteModelCell(QuoteViewModel(quoteModel: quote)))
            }
        }
        sections.append(.quoteModelSection(rows))
        
        rows = [QuoteRow]()
        if let quoteRequest = quoteData?.quoteRequest {
            rows.append(QuoteRow.quoteRequestCell(QuoteRequestCollectionViewModel(quoteRequest: quoteRequest)))
        }
        sections.append(.quoteRequestSection(rows))
        
        rows = [QuoteRow]()
        if let quoteWorks = quoteData?.quoteWorks {
            rows.append(QuoteRow.quoteWorksCell(QuoteWorksCollectionCellViewModel(quoteWorksModel: quoteWorks)))
        }
        sections.append(.quoteWorksSection(rows))
    }
}

extension QuotesCollectionViewControllerViewModel {
    var navigationTitle: String? {
        return "Quotes"
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
    
    func row(for indexPath: IndexPath) -> QuoteRow? {
        return sections[indexPath.section].row(for: indexPath)
    }
    
    func getIdentifier(for cell: ReuseCellIdentifier) -> String {
        return cell.getIdentifier(for: cell)
    }

}

enum ReuseCellIdentifier {
    case defaultCell
    case myQuoteCell
    case requestQuoteCell
    case workQuoteCell
    
    func getIdentifier(for cell : ReuseCellIdentifier) -> String {
        switch cell {
        case .defaultCell:
            return "Cell"
        case .myQuoteCell:
            return "myQuoteCell"
        case .requestQuoteCell:
            return "quoteRequestCell"
        case .workQuoteCell:
            return "quoteWorksCell"
        }
    }
}

enum QuoteRow {
    case quoteModelCell(QuotesCollectionViewCellConfigurable)
    case quoteRequestCell(QuotesRequestCollectionViewCellConfigurable)
    case quoteWorksCell(QuotesWorksCollectionViewCellConfigurable)
}

enum QuoteSection {
    case quoteModelSection([QuoteRow])
    case quoteRequestSection([QuoteRow])
    case quoteWorksSection([QuoteRow])
    
    func numberOfRows() -> Int {
        switch self {
        case let .quoteModelSection(quoteModelRows):
            return quoteModelRows.count
         case let .quoteRequestSection(quoteRequestRows):
            return quoteRequestRows.count
        case let .quoteWorksSection(quoteWorkRows):
            return quoteWorkRows.count
        }
    }
    
    func row(for indexPath: IndexPath) -> QuoteRow? {
        switch self {
        case let .quoteModelSection(quoteModelRows):
            return quoteModelRows[indexPath.row]
         case let .quoteRequestSection(quoteRequestRows):
             return quoteRequestRows[indexPath.row]
        case let .quoteWorksSection(quoteWorkRows):
            return quoteWorkRows[indexPath.row]
        }
    }
    
    func title() -> String {
        switch self {
        case .quoteModelSection(_):
            return "My Quotes"
        case .quoteRequestSection(_):
            return "Request a Quote"
        case .quoteWorksSection(_):
            return "How it works"
        }
    }
}

