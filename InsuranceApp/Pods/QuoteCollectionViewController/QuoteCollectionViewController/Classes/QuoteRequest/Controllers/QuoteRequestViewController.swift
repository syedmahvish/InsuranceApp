import UIKit
import ProfileTableViewController
import CustomDropDown

class QuoteRequestViewController: UIViewController {
    
    lazy var profileTableViewController = ProfileTableViewController()
    lazy var quoteRequestBillView = QuoteRequestBillView(frame: .zero)
    lazy var quoteRequestVC = QuoteRequestTableViewController()
    public var profileInformation : ProfileInformationModel?
    public var stateDropDownArray : [StateModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quote Request"
        layoutView()
        setupConstraints()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationItems()
    }
    
    private func layoutView() {
        view.backgroundColor = .systemGray6
        view.addSubview(quoteRequestBillView)
        view.addSubview(quoteRequestVC.tableView)
    }
    
    func loadPaymentBillData(with amount : String, type : String) {
        let dataProvider = QuoteRequestDataProvider.sharedInstance
        var billPaymentModel =  dataProvider.loadBillData()
        billPaymentModel.amount = amount
        billPaymentModel.categoryType = type
        quoteRequestBillView.configureView(with: QuoteRequestBillViewViewModel(quoteBillPaymentModel: billPaymentModel))
    }
    
    private func setupConstraints() {
        quoteRequestBillView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view).inset(10)
        }
        quoteRequestVC.tableView.snp.makeConstraints { make in
            make.top.equalTo(quoteRequestBillView.snp.bottom).inset(-10)
            make.left.right.bottom.equalTo(view)
        }
    }
   
}

extension QuoteRequestViewController {
    
    private func setNavigationItems() {
        //navigationController?.navigationBar.barTintColor = .lightGray
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleProfileButtonTapped))
    }
    
    @objc func handleProfileButtonTapped() {
        profileTableViewController.profileInformation = profileInformation
        profileTableViewController.stateDropDownArray = stateDropDownArray
        navigationController?.pushViewController(profileTableViewController, animated: true)
    }
}
