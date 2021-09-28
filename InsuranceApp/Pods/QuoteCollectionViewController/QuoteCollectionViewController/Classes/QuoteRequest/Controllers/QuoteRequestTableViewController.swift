import UIKit

class QuoteRequestTableViewController: UITableViewController {
    
    private var quoteRequestViewModel : QuoteRequestTableViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteRequestViewModel = QuoteRequestTableViewViewModel()
        setupInitailParameters()
        setupRegister()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
    }
}

// MARK: - Initail and data setup
extension QuoteRequestTableViewController {
    
    private func setupInitailParameters() {
        view.backgroundColor = .white
        title = quoteRequestViewModel?.navigationTitle
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        var headerView = QuoteRequestTableViewHeader(frame: .zero)
        headerView.configureLabel(withText: quoteRequestViewModel?.navigationTitle ?? "--")
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRegister() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(QuoteRequestPopupTableViewCell.self, forCellReuseIdentifier: QuoteRequestPopupTableViewCell.reuseIdentifier)
        tableView.register(QuoteMakePaymentTableViewCell.self, forCellReuseIdentifier: QuoteMakePaymentTableViewCell.reuseIdentifier)
        tableView.register(QuoteRequestHeaderView.self, forHeaderFooterViewReuseIdentifier: QuoteRequestHeaderView.reuseIdentifier)
    }
    
    private func createQuoteRequestPopupCell(for indexPath : IndexPath, style : UITableViewCell.CellStyle = .subtitle) -> QuoteRequestPopupTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: QuoteRequestPopupTableViewCell.reuseIdentifier, for: indexPath) as? QuoteRequestPopupTableViewCell
        if cell == nil {
            cell = QuoteRequestPopupTableViewCell(style: style, reuseIdentifier: QuoteRequestPopupTableViewCell.reuseIdentifier)
        }
        return cell!
    }
    
    private func createQuoteMakePaymentCell(for indexPath : IndexPath, style : UITableViewCell.CellStyle = .default) -> QuoteMakePaymentTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: QuoteMakePaymentTableViewCell.reuseIdentifier, for: indexPath) as? QuoteMakePaymentTableViewCell
        if cell == nil {
            cell = QuoteMakePaymentTableViewCell(style: style, reuseIdentifier: QuoteMakePaymentTableViewCell.reuseIdentifier)
        }
        return cell!
    }
}

extension QuoteRequestTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = quoteRequestViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = quoteRequestViewModel else {
            return 0
        }
        return viewModel.numberOfRowsPerSection(section: section)
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: QuoteRequestHeaderView.reuseIdentifier) as? QuoteRequestHeaderView
        if headerView == nil {
            headerView =
                QuoteRequestHeaderView(reuseIdentifier: QuoteRequestHeaderView.reuseIdentifier)
        }
        guard let viewModel = quoteRequestViewModel,
              let sectionHeader = viewModel.sectionHeader(section: section) else {
            return headerView
        }
        headerView?.delegate = self
        headerView?.configureSection(with: sectionHeader)
        let image = sectionHeader.isHidden ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill"
        headerView?.headerButton.setBackgroundImage(UIImage(systemName: image), for: .normal)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = quoteRequestViewModel,
              let row = viewModel.row(for: indexPath) else {
            return UITableViewCell()
        }
        
        switch row {
        case let .updatePaymentMethod(cellInfo) :
            let cell = createQuoteRequestPopupCell(for: indexPath)
            cell.configureCell(withUpdatePayment: cellInfo)
            return cell
        case let .makePayment(cellInfo) :
            let cell = createQuoteMakePaymentCell(for: indexPath)
            cell.configureCell(withMakePayment: cellInfo)
            return cell
        case let .schedulePayment(cellInfo) :
            let cell = createQuoteRequestPopupCell(for: indexPath)
            if indexPath.row == 1 {
                cell.configureCell(withSchedulePayment: cellInfo, indexPathForButton: indexPath)
            }else {
                cell.configureCell(withSchedulePayment: cellInfo)
            }
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected : \(indexPath.section) = \(indexPath.row)")
    }
    
}

extension QuoteRequestTableViewController : QuoteRequestHeaderViewConfigure {
    
    func toggleSection(selectedIndex: Int) {
        guard let viewModel = quoteRequestViewModel,
              let sectionHeader = viewModel.sectionHeader(section: selectedIndex) else {
            return
        }
        let updateSectionModel = SectionHeaderModel(title: sectionHeader.title, image: sectionHeader.image, isHidden: sectionHeader.isHidden ? false : true, index: sectionHeader.index)
        viewModel.sectionHeaderArray?.remove(at: selectedIndex)
        viewModel.sectionHeaderArray?.insert(updateSectionModel, at: selectedIndex)
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: selectedIndex), with: .none)
        }
    }
}

extension QuoteRequestTableViewController : CurrentPaymentPlanSelectionConfigurable {
    enum SchedulePaymentRowsIndex : Int {
        case billingSchedule = 20
        case paymentPlan = 21
        case paperlessBilling = 22
    }
    
    func showAndEditCurrentPaymentPlan(index : Int) {
        switch index {
        case SchedulePaymentRowsIndex.paymentPlan.rawValue :
            showChangePaymentPlanTableViewController()
        default:
            return
        }
    }
    
    private func showChangePaymentPlanTableViewController() {
        let changePaymentPlanTableViewController = ChangePaymentPlanTableViewController()
        changePaymentPlanTableViewController.profileInformation = nil
        changePaymentPlanTableViewController.stateDropDownArray = nil
        present(changePaymentPlanTableViewController, animated: true, completion: nil)
    }
}
