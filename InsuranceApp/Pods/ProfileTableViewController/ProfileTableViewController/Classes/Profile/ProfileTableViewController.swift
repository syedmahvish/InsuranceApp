import UIKit
import Foundation
import CustomDropDown
import Generics

public class ProfileTableViewController: UITableViewController {
    
    enum SectionName : Int {
        case detailSection = 0
        case editableSection = 1
        case unknown
    }
    
    enum RowName : Int {
        case streetRow = 0
        case apartmentRow = 1
        case cityRow = 2
        case stateRow = 3
        case countryRow = 4
        case zipRow = 5
        case phoneRow = 6
        case emailRow = 7
    }
    
    public var profileInformation : ProfileInformationModel?
    var cellInformationArray = [ProfileInformationViewModel]()
    var showDropDown : Bool = false
    var stateDropDown : CustomDropDown?
    var stateDropDownHeight : CGFloat? = 0.0
    public var stateDropDownArray : [StateModel]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupInitailParameters()
        setupRegister()
        setupTableViewHeaderandFooterView()
        setupDataSource()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
        updateHeaderViewHeight(for: tableView.tableFooterView)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationItems()        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataSource()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Intial Table view Setup
extension ProfileTableViewController {
    
    private func setupInitailParameters() {
        self.view.backgroundColor = .white
        self.title = TitleConstant.detailProfileTitle.rawValue
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRegister() {
        self.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        self.tableView.register(ProfileDetailViewCell.self, forCellReuseIdentifier: ProfileDetailViewCell.reuseIdentifier)
        self.tableView.register(ShowDropDownTableViewCell.self, forCellReuseIdentifier: ShowDropDownTableViewCell.reuseIdentifier)
        self.tableView.register(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
    }
    
    private func setupDataSource() {
        cellInformationArray = ProfileInformationViewModel.getProfileInformationArray(profileInformation: profileInformation ?? nil)
    }
    
    private func setupTableViewHeaderandFooterView() {
        let headerView = ProfileHeaderView(frame: .zero)
        headerView.configureLabel(withText: TitleConstant.detailTableViewHeader.rawValue)
        tableView.tableHeaderView = headerView
        
        let footerView = ProfileFooterView(frame: .zero)
        footerView.delegate = self
        footerView.addButtonAction()
        tableView.tableFooterView = footerView
    }
    
    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "chevron.left.circle") , style: .done, target: self, action: #selector(handleBackButtonTapped))
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: nil)
    }
    
    @objc func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source
extension ProfileTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SectionName.detailSection.rawValue:
            return 1
        case SectionName.editableSection.rawValue:
            if showDropDown {
                return cellInformationArray.count + 1
            } 
            return cellInformationArray.count
        default:
            return 0
        }
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case SectionName.detailSection.rawValue:
            var cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailViewCell.reuseIdentifier, for: indexPath) as? ProfileDetailViewCell
            if cell == nil {
                cell = ProfileDetailViewCell(style: .default, reuseIdentifier: ProfileDetailViewCell.reuseIdentifier)
            }
            cell?.profileDetailView?.intialViewSetup(profileInformation: profileInformation)
            return cell!
            
        case SectionName.editableSection.rawValue:
            if indexPath.row == RowName.stateRow.rawValue {
                var cell = tableView.dequeueReusableCell(withIdentifier: ProfileStateDropDownTableViewCell.reuseIdentifier, for: indexPath) as? ProfileStateDropDownTableViewCell
                if cell == nil {
                    cell = ProfileStateDropDownTableViewCell(style: .default, reuseIdentifier: ProfileStateDropDownTableViewCell.reuseIdentifier)
                }
                if  indexPath.row  < cellInformationArray.count {
                    let currentCellInformation = cellInformationArray[indexPath.row]
                    cell?.infoLabel.labelWithBlueColorAndSystemFont(withTittle: currentCellInformation.labelTitle, fontSize: Float(FontConstant.FONT_SIZE_17.rawValue))
                    cell?.stateDropDownButton.setTitle(currentCellInformation.textFieldValue, for: .normal)
                    cell?.stateDropDownButton.stateModelArray = stateDropDownArray
                    cell?.stateDropDownButton.delegate = self
                    stateDropDown = cell?.stateDropDownButton.dropDown
                }
                return cell!
            }
            if showDropDown,
               indexPath.row == RowName.stateRow.rawValue + 1 {
                var showStatecell = tableView.dequeueReusableCell(withIdentifier: ShowDropDownTableViewCell.reuseIdentifier, for: indexPath) as? ShowDropDownTableViewCell
                if showStatecell == nil {
                    showStatecell = ShowDropDownTableViewCell(style: .default, reuseIdentifier: ShowDropDownTableViewCell.reuseIdentifier)
                    
                }
                if let view = stateDropDown,
                   let cellContentView = showStatecell?.contentView,
                   let height = stateDropDownHeight{
                    showStatecell?.configureShowView(view: view, height: height)
                    view.showDropDown(frame: CGRect(x: cellContentView.frame.origin.x, y: cellContentView.frame.origin.y, width: cellContentView.frame.width, height: height))
                    
                }
                return showStatecell!
            }
            var othercell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell
            if othercell == nil {
                othercell = ProfileTableViewCell(style: .default, reuseIdentifier: ProfileTableViewCell.reuseIdentifier)
            }
            var currentIndex = indexPath.row
            if showDropDown,
               indexPath.row > 3 {
                currentIndex -= 1
            }
            let currentCellInformation = cellInformationArray[currentIndex]
            othercell?.cofigureCell(withProfileInformation : currentCellInformation)
            return othercell!
        default:
            return UITableViewCell()
        }
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SectionName.editableSection.rawValue {
            var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionHeaderView.reuseIdentifier) as? ProfileSectionHeaderView
            if headerView == nil {
                headerView = ProfileSectionHeaderView(reuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
            }
            headerView?.configureLabel(withText: TitleConstant.editInfo.rawValue)
            return headerView
        }
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SectionName.editableSection.rawValue {
            return 44
        }
        return 0
    }
}

// MARK: - Update Information
extension ProfileTableViewController : UpdateProfileInformation {
    
    func updateProfileInformation() {
        var totalRows = cellInformationArray.count
        if showDropDown {
            totalRows += 1
        }
        for index in 0...totalRows {
            var currentIndex = index
            if showDropDown,
               currentIndex > RowName.stateRow.rawValue {
                currentIndex += 1
            }
            if let cell = tableView.cellForRow(at: IndexPath(row: currentIndex, section: SectionName.editableSection.rawValue)) as? ProfileTableViewCell {
                let currentCellInformation = cell.infoTextField.text
                switch currentIndex {
                case showDropDown ? RowName.phoneRow.rawValue + 1 : RowName.phoneRow.rawValue:
                    if profileInformation?.phone != currentCellInformation {
                        profileInformation?.phone = currentCellInformation
                        
                    }
                case showDropDown ? RowName.emailRow.rawValue + 1 : RowName.emailRow.rawValue:
                    if profileInformation?.email != currentCellInformation {
                        profileInformation?.email = currentCellInformation
                    }
                default:
                    break
                }
            }
        }
        setupDataSource()
        tableView.reloadSections(IndexSet(integer: SectionName.detailSection.rawValue), with: UITableView.RowAnimation.none)
    }
    
    func updateStateInformation(with selectedState : String?) {
        if let state = selectedState {
            profileInformation?.location?.state = state
            setupDataSource()
            tableView.reloadSections(IndexSet(integer: SectionName.editableSection.rawValue), with: UITableView.RowAnimation.none)
        }
    }
}

// MARK: - DropDown Delegates
extension ProfileTableViewController : CustomDropDownButtonDelegate {
    
    public func showDropDown(height : CGFloat) {
        showDropDown = !showDropDown
        stateDropDownHeight = height
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    public func hideDropDown(with selectedState : String?) {
        showDropDown = false
        updateStateInformation(with: selectedState)
    }
}
