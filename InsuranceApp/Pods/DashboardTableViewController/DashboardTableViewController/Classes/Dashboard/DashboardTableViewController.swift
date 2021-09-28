import UIKit
import ProfileTableViewController
import CustomDropDown
import Generics

public class DashboardTableViewController: UITableViewController {
    lazy var profileTableViewController = ProfileTableViewController()
    private var dashBoardViewModel : DashboardTableViewControllerConfigurable?
    public var profileInformation : ProfileInformationModel?
    public var stateDropDownArray : [StateModel]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        dashBoardViewModel = DashboardTableViewControllerViewModel(profileInformation: profileInformation, stateDropDownArray: stateDropDownArray)
        setupInitailParameters()
        setupRegister()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationItems()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Initialization and Configuration
extension DashboardTableViewController {
    private func setupInitailParameters() {
        view.backgroundColor = .white
        title = dashBoardViewModel?.navigationTitle
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRegister() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.register(IDsTableViewCell.nibForIdsTableViewCell(), forCellReuseIdentifier: IDsTableViewCell.reuseIdentifier)
        self.tableView.register(UpcomingBillsTableViewCell.self, forCellReuseIdentifier: UpcomingBillsTableViewCell.reuseIdentifier)
        self.tableView.register(ReportAndRequestTableViewCell.self, forCellReuseIdentifier: ReportAndRequestTableViewCell.reuseIdentifier)
        self.tableView.register(ContactAgentTableViewCell.self, forCellReuseIdentifier: ContactAgentTableViewCell.reuseIdentifier)
        self.tableView.register(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
    }
    
    private func setNavigationItems() {
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleProfileButtonTapped))
    }
    
    @objc func handleProfileButtonTapped() {
        profileTableViewController.profileInformation = profileInformation
        profileTableViewController.stateDropDownArray = stateDropDownArray
        self.navigationController?.pushViewController(profileTableViewController, animated: true)
    }
}

// MARK: - Table view data source
extension DashboardTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = dashBoardViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = dashBoardViewModel else {
            return 0
        }
        
        return viewModel.numberOfRows(for: section)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = dashBoardViewModel,
              let row = viewModel.rows(for: indexPath) else {
            return UITableViewCell()
        }
        
        switch row {
        case let .billsInfoRows(billsInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: UpcomingBillsTableViewCell.reuseIdentifier, for: indexPath) as? UpcomingBillsTableViewCell
            if cell == nil {
                cell = UpcomingBillsTableViewCell(style: .default, reuseIdentifier: ReportAndRequestTableViewCell.reuseIdentifier)
            }
            if let billsModel = billsInfo.upcomingBillsModel {
                cell?.configureCell(with: billsModel)
            }
            return cell!
        case let .idsInfoRows(idsInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: IDsTableViewCell.reuseIdentifier, for: indexPath) as? IDsTableViewCell
            cell?.awakeFromNib()
            if cell == nil {
                cell = IDsTableViewCell()
            }
            cell?.configureCell(with: idsInfo)
            return cell!
        case let .reportAndRequestTableViewCell(reportAndRequestInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: ReportAndRequestTableViewCell.reuseIdentifier, for: indexPath) as? ReportAndRequestTableViewCell
            if cell == nil {
                cell = ReportAndRequestTableViewCell(style: .default, reuseIdentifier: ReportAndRequestTableViewCell.reuseIdentifier)
            }
            cell?.accessoryType = .disclosureIndicator
            cell?.configureCell(withInfo: reportAndRequestInfo)
            return cell!
        case let .contactTableViewCell(profileInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: ContactAgentTableViewCell.reuseIdentifier, for: indexPath) as? ContactAgentTableViewCell
            if cell == nil {
                cell = ContactAgentTableViewCell(style: .default, reuseIdentifier: ContactAgentTableViewCell.reuseIdentifier)
            }
            cell?.configureContactAgent(withProfileInformation: profileInformation)
            return cell!
        }
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionHeaderView.reuseIdentifier) as? ProfileSectionHeaderView
        if headerView == nil {
            headerView = ProfileSectionHeaderView(reuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
        }
        guard let viewModel = dashBoardViewModel else {
            return headerView
        }
        headerView?.configureLabel(withText: viewModel.titleForSection(for: section))
        return headerView
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = dashBoardViewModel else {
            return 0
        }
        return viewModel.heightForRows(for: indexPath)
    }
}
