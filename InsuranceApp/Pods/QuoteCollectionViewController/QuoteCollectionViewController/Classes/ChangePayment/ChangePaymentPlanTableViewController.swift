import UIKit
import ProfileTableViewController
import CustomDropDown

class ChangePaymentPlanTableViewController: UITableViewController {
    
    private var changePaymentPlanViewModel : ChangePaymentPlanTableViewViewModel?
    lazy var profileTableViewController = ProfileTableViewController()
    public var profileInformation : ProfileInformationModel?
    public var stateDropDownArray : [StateModel]?
    private var showSectionFooter : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePaymentPlanViewModel = ChangePaymentPlanTableViewViewModel(profileInformation: profileInformation, stateDropDownArray: stateDropDownArray)
        setupInitailParameters()
        setupRegister()
    }
}

extension ChangePaymentPlanTableViewController {
    
    private func setupInitailParameters() {
        view.backgroundColor = .white
        title = changePaymentPlanViewModel?.navigationTitle
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRegister() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(SelectPaymnetPlanTableViewCell.self, forCellReuseIdentifier: SelectPaymnetPlanTableViewCell.reuseIdentifier)
        tableView.register(SchedulePaymentTableViewCell.self, forCellReuseIdentifier: SchedulePaymentTableViewCell.reuseIdentifier)
        tableView.register(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
    }
    
    private func createSelectPaymnetPlanTableViewCell(for indexPath : IndexPath, style : UITableViewCell.CellStyle = .default) -> SelectPaymnetPlanTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SelectPaymnetPlanTableViewCell.reuseIdentifier, for: indexPath) as? SelectPaymnetPlanTableViewCell
        if cell == nil {
            cell = SelectPaymnetPlanTableViewCell(style: style, reuseIdentifier: SelectPaymnetPlanTableViewCell.reuseIdentifier)
        }
        return cell!
    }
    
    private func createSchedulePaymentTableViewCell(for indexPath : IndexPath, style : UITableViewCell.CellStyle = .default) -> SchedulePaymentTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SchedulePaymentTableViewCell.reuseIdentifier, for: indexPath) as? SchedulePaymentTableViewCell
        if cell == nil {
            cell = SchedulePaymentTableViewCell(style: style, reuseIdentifier: SchedulePaymentTableViewCell.reuseIdentifier)
        }
        return cell!
    }
}

extension ChangePaymentPlanTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = changePaymentPlanViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = changePaymentPlanViewModel else {
            return 0
        }
        return viewModel.numberOfRowsPerSection(section: section)
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionHeaderView.reuseIdentifier) as? ProfileSectionHeaderView
        if headerView == nil {
            headerView =
                ProfileSectionHeaderView(reuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
        }
        guard let viewModel = changePaymentPlanViewModel else {
            return headerView
        }
        headerView?.configureLabel(withText: viewModel.title(section: section))
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionHeaderView.reuseIdentifier) as? ProfileSectionHeaderView
        if footerView == nil {
            footerView =
                ProfileSectionHeaderView(reuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
        }
        guard let viewModel = changePaymentPlanViewModel else {
            return footerView
        }
        footerView?.delegate = self
        footerView?.configureButton(withText: "Save")
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return showSectionFooter ? 60 : 0
        }
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = changePaymentPlanViewModel,
              let row = viewModel.row(for: indexPath) else {
            return UITableViewCell()
        }
        
        switch row {
        case let .selectPaymentRows(cellInfo) :
            let cell = createSelectPaymnetPlanTableViewCell(for: indexPath)
            cell.configureCell(with: cellInfo)
            return cell
        case let .schedulePaymentRows(cellInfo) :
            let cell = createSchedulePaymentTableViewCell(for: indexPath)
            cell.configureCell(with: cellInfo)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = cell.accessoryType == .none ? .checkmark : .none
            updateOtherRowsExcept(selectedIndex: indexPath)
        }
    }
    
    private func updateOtherRowsExcept(selectedIndex : IndexPath) {
        guard let viewModel = changePaymentPlanViewModel else {
            return
        }
        let count = viewModel.numberOfRowsPerSection(section: selectedIndex.section)
        for i in 0...count {
            if i != selectedIndex.row {
                if let cell = tableView.cellForRow(at: IndexPath(row: i, section: selectedIndex.section)) {
                    cell.accessoryType = .none
                }
            }
        }
        viewModel.updateSections(for: selectedIndex.row)
        showSectionFooter = true
        tableView.reloadSections(IndexSet(integer: selectedIndex.section), with: .none)
    }
    
}

extension ChangePaymentPlanTableViewController : ProfileSectionHeaderViewFooterButtonConfigurable {
    
    func saveData() {
        showSectionFooter = false
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        
        view.showLoading(style: .large, color: .red)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.stopLoading()
        }
    }
}
