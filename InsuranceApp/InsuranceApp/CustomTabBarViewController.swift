import UIKit
import ProfileTableViewController
import CustomDropDown
import PoliciesTableViewController
import DashboardTableViewController
import QuoteCollectionViewController

class CustomTabBarViewController: UITabBarController {
    
    private var dashboardTableViewController : DashboardTableViewController?
    private var profileTableViewController : ProfileTableViewController?
    private var policiesTableViewController : PoliciesTableViewController?
    private var instagramTableViewController : InstagramTableViewController?
    private var quotesCollectionViewController : QuotesCollectionViewController?
    var profileInformation : ProfileInformationModel?
    var stateDropDownArray : [StateModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeData()
    }
}

//MARK:- Setup and initialize view
extension CustomTabBarViewController {

    private func setupTabBar() {
        dashboardTableViewController = DashboardTableViewController()
        profileTableViewController = ProfileTableViewController()
        policiesTableViewController = PoliciesTableViewController()
        instagramTableViewController = InstagramTableViewController()
        quotesCollectionViewController = QuotesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

        let dashBoardTableVC = createTabFrom(dashboardTableViewController!, UIImage(systemName: "house.fill"), 0, isEnable: true)
        let profileTableVC = createTabFrom(profileTableViewController!,  UIImage(systemName: "person.circle"), 1, isEnable: true)
        let policiesTableVC = createTabFrom(policiesTableViewController!, UIImage(systemName: "dollarsign.square"), 2, isEnable: true)
        let quotesCollectionVC = createTabFrom(quotesCollectionViewController! , UIImage(systemName: "bag"), 3, isEnable: true)
        let defaultVC = createTabFrom(instagramTableViewController!, UIImage(systemName: "table.badge.more"), 3,isEnable: true)
        viewControllers = [dashBoardTableVC, profileTableVC, policiesTableVC, quotesCollectionVC,defaultVC]
    }
    
    private func createTabFrom(_ vc: UIViewController, _ image: UIImage?, _ tag: Int, isEnable : Bool = false) -> UINavigationController {
        vc.tabBarItem = .init(title: "", image: image, tag: tag)
        vc.tabBarItem.isEnabled = isEnable
        return .init(rootViewController: vc)
    }

    private func initializeData() {
        dashboardTableViewController?.profileInformation = profileInformation
        dashboardTableViewController?.stateDropDownArray = stateDropDownArray
        policiesTableViewController?.profileInformation = profileInformation
        policiesTableViewController?.stateDropDownArray = stateDropDownArray
        profileTableViewController?.profileInformation = profileInformation
        profileTableViewController?.stateDropDownArray = stateDropDownArray
        quotesCollectionViewController?.profileInformation = profileInformation
        quotesCollectionViewController?.stateDropDownArray = stateDropDownArray
    }
}
