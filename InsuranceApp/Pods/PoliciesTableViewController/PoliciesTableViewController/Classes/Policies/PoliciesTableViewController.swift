import UIKit
import ProfileTableViewController
import CustomDropDown
import Generics
import PopupViewController

public class PoliciesTableViewController: UITableViewController {
    
    lazy var profileTableViewController = ProfileTableViewController()
    private var policiesViewModel : PoliciesTableViewControllerConfigurable?
    public var profileInformation : ProfileInformationModel?
    public var stateDropDownArray : [StateModel]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        policiesViewModel = PoliciesTableViewControllerViewModel(profileInformation: profileInformation, stateDropDownArray: stateDropDownArray)
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

// MARK: - Initail and data setup
extension PoliciesTableViewController {
    
    private func setupInitailParameters() {
        view.backgroundColor = .white
        title = policiesViewModel?.navigationTitle
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRegister() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(HomeRentalTableViewCell.self, forCellReuseIdentifier: HomeRentalTableViewCell.reuseIdentifier)
        tableView.register(ReportAndRequestTableViewCell.self, forCellReuseIdentifier: ReportAndRequestTableViewCell.reuseIdentifier)
        tableView.register(ContactAgentTableViewCell.self, forCellReuseIdentifier: ContactAgentTableViewCell.reuseIdentifier)
        tableView.register(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileSectionHeaderView.reuseIdentifier)
    }
}

// MARK: - Table view data source
extension PoliciesTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = policiesViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = policiesViewModel else {
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
        guard let viewModel = policiesViewModel else {
            return headerView
        }
        headerView?.configureLabel(withText: viewModel.title(section: section))
        return headerView
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = policiesViewModel,
              let row = policiesViewModel?.row(for: indexPath) as? PoliciesRow else {
            return UITableViewCell()
        }
        
        switch row {
        case let .autoRenewalTableViewCell(cellInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: ContactAgentTableViewCell.reuseIdentifier, for: indexPath) as? ContactAgentTableViewCell
            if cell == nil {
                cell = ContactAgentTableViewCell(style: .default, reuseIdentifier: ContactAgentTableViewCell.reuseIdentifier)
            }
            cell?.configureAuto(withAutoInformation: cellInfo)
            return cell!
        case let .homeRentalTableViewCell(cellInfo):
            var cell = tableView.dequeueReusableCell(withIdentifier: HomeRentalTableViewCell.reuseIdentifier, for: indexPath) as? HomeRentalTableViewCell
            if cell == nil {
                cell = HomeRentalTableViewCell(style: .default, reuseIdentifier: HomeRentalTableViewCell.reuseIdentifier)
            }
            cell?.configureCell(homeRentalViewModel: cellInfo)
            return cell!
        case let .reportAndRequestTableViewCell(cellInfo) :
            var cell = tableView.dequeueReusableCell(withIdentifier: ReportAndRequestTableViewCell.reuseIdentifier, for: indexPath) as? ReportAndRequestTableViewCell
            if cell == nil {
                cell = ReportAndRequestTableViewCell(style: .default, reuseIdentifier: ReportAndRequestTableViewCell.reuseIdentifier)
            }
            cell?.accessoryType = .disclosureIndicator
            cell?.configureCell(withInfo: cellInfo)
            return cell!
        }
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = policiesViewModel?.row(for: indexPath) else {
            return
        }
        switch row {
        case let .autoRenewalTableViewCell(cellInfo):
            showPopup(for: cellInfo)
        default:
            return
        }
    }
    
    private func showPopup(for autoModel : AutoRenewalInfoConfigurable) {
        guard let model = autoModel.autoRenewalModel,
              let image = model.billImage,
              let name = model.name else {
            return
        }
        
        let paymentModel = PaymentModel(imageString: image , nameLabelString: name, duePaymentString: "300", buttonTitle: "Make Pay", viewTitle: "Auto Bill Payment")
        let paymentModelConfigurable = PaymentViewModel(paymentModel: paymentModel)
        let popupViewController = PopupViewController()
        
        self.present(popupViewController, animated: true, completion: nil)
        
        popupViewController.viewType = .payment(paymentModelConfigurable)
        popupViewController.delegate?.loadDataInView(with: .payment(paymentModelConfigurable))
        popupViewController.delegate?.setButton(with: .payment(paymentModelConfigurable))
        popupViewController.delegate?.setTitle(with:.payment(paymentModelConfigurable))
    }
}

extension PoliciesTableViewController {
    
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleProfileButtonTapped))
    }
    
    @objc func handleProfileButtonTapped() {
        profileTableViewController.profileInformation = profileInformation
        profileTableViewController.stateDropDownArray = stateDropDownArray
        navigationController?.pushViewController(profileTableViewController, animated: true)
    }
}


