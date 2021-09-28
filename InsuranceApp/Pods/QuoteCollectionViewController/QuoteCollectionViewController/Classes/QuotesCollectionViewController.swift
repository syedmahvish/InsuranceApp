import UIKit
import ProfileTableViewController
import CustomDropDown
import PopupViewController
import SnapKit

public class QuotesCollectionViewController: UICollectionViewController {
    
    private var quoteViewModel : QuotesCollectionViewControllerConfigurable?
    lazy var profileTableViewController = ProfileTableViewController()
    public var profileInformation : ProfileInformationModel?
    public var stateDropDownArray : [StateModel]?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        quoteViewModel = QuotesCollectionViewControllerViewModel(profileInformation: profileInformation, stateDropDownArray: stateDropDownArray)
        setupInitailParameter()
        setupCellRegister()
        setNavigationItems()
    }
    
    private func setupInitailParameter() {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance:
                                                                .insetGrouped)
        layoutConfig.headerMode = .supplementary
        collectionView?.collectionViewLayout =
            UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        self.title = quoteViewModel?.navigationTitle
    }
    
    private func setupCellRegister() {
        guard let viewModel = quoteViewModel else {
            return
        }
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: viewModel.getIdentifier(for: .defaultCell))
        collectionView?.register(QuotesCollectionViewCell.self, forCellWithReuseIdentifier: viewModel.getIdentifier(for: .myQuoteCell))
        collectionView?.register(QuoteRequestCollectionViewCell.self, forCellWithReuseIdentifier:  viewModel.getIdentifier(for: .requestQuoteCell))
        collectionView?.register(QuoteWorksCollectionViewCell.self, forCellWithReuseIdentifier: viewModel.getIdentifier(for: .workQuoteCell))
        collectionView?.register(QuoteCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuoteCollectionViewHeader.reuseIdentifier)
    }
}

extension QuotesCollectionViewController {
    private func setNavigationItems() {
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleProfileButtonTapped))
    }
    
    @objc func handleProfileButtonTapped() {
        profileTableViewController.profileInformation = profileInformation
        profileTableViewController.stateDropDownArray = stateDropDownArray
        navigationController?.pushViewController(profileTableViewController, animated: true)
    }
}

extension QuotesCollectionViewController {
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = quoteViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = quoteViewModel else {
            return 0
        }
        return viewModel.numberOfRowsPerSection(section: section)
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = quoteViewModel,
              let row = viewModel.row(for: indexPath) else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }
        
        switch  row {
        case let .quoteModelCell(quoteViewModel):
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.getIdentifier(for: .myQuoteCell), for: indexPath) as? QuotesCollectionViewCell
            if cell == nil {
                cell = QuotesCollectionViewCell(frame: .zero)
            }
            cell?.configureCell(with: quoteViewModel)
            return cell!
        case let .quoteRequestCell(quoteRequestViewModel):
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.getIdentifier(for: .requestQuoteCell), for: indexPath) as? QuoteRequestCollectionViewCell
            if cell == nil {
                cell = QuoteRequestCollectionViewCell(frame: .zero)
            }
            cell?.requestTable?.delegate = self
            cell?.configureCell(with: quoteRequestViewModel)
            return cell!
        case let .quoteWorksCell(quoteWorksViewModel):
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.getIdentifier(for: .workQuoteCell), for: indexPath) as? QuoteWorksCollectionViewCell
            if cell == nil {
                cell = QuoteWorksCollectionViewCell(frame: .zero)
            }
            cell?.delegate = self
            cell?.configureCell(with: quoteWorksViewModel)
            return cell!
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            var sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: QuoteCollectionViewHeader.reuseIdentifier, for: indexPath) as? QuoteCollectionViewHeader
            if sectionHeader == nil {
                sectionHeader = QuoteCollectionViewHeader(frame: .zero)
            }
            guard let viewModel = quoteViewModel else {
                return sectionHeader!
            }
            sectionHeader?.configureLabel(withText: viewModel.title(section: indexPath.section))
            return sectionHeader!
        }
        return UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}

extension QuotesCollectionViewController : QuotesWorksCollectionViewCellConfigurable {
    func showPopup(with popup: PopupViewController) {
        self.present(popup, animated: true, completion: nil)
    }
}

extension QuotesCollectionViewController : QuoteRequestCollectionViewControllerConfigurable {
    
    func showQuoteRequestTVC(with quoteRequestVC : QuoteRequestViewController) {
        quoteRequestVC.profileInformation = profileInformation
        quoteRequestVC.stateDropDownArray = stateDropDownArray
        navigationController?.pushViewController(quoteRequestVC, animated: true)
    }
}
