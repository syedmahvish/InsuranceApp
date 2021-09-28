import UIKit

class QuoteRequestCollectionViewController: UICollectionViewController {
    
    var quoteRequest : QuoteRequest?
    var delegate : QuoteRequestCollectionViewControllerConfigurable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitailParameter()
        setupCellRegister()
    }
    
    private func setupInitailParameter() {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 50)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
    }
    
    private func setupCellRegister() {
        collectionView?.register(QuoteRequestInnerCollectionViewCell.self, forCellWithReuseIdentifier: "innerQuoteRequestCell")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func reloadQuoteRequestView() {
        collectionView?.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sectionsCount = quoteRequest?.requestQuotation?.count else {
            return 0
        }
        return sectionsCount
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let request = quoteRequest?.requestQuotation,
              let rowCount = request[section].requestValueArray?.count else {
            return 0
        }
        return rowCount+1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "innerQuoteRequestCell", for: indexPath) as? QuoteRequestInnerCollectionViewCell
        if cell == nil {
            cell = QuoteRequestInnerCollectionViewCell(frame: .zero)
        }
        guard let request = quoteRequest?.requestQuotation
        else {
            return cell!
        }
        
        let currentData = request[indexPath.section]
        
        if indexPath.row == 0,
           let title = currentData.requestTitle {
            cell?.configureCell(with: title)
            cell?.isUserInteractionEnabled =  false
        } else {
            if let value = currentData.requestValueArray?[indexPath.row-1]{
                cell?.configureCell(with: String(value))
            }
        }
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let request = quoteRequest?.requestQuotation
        else {
            return
        }
        let currentData = request[indexPath.section]
        if indexPath.row > 0,
           let type = currentData.requestTitle,
           let amount = currentData.requestValueArray?[indexPath.row-1] {
            let quoteRequestViewController = QuoteRequestViewController()
            quoteRequestViewController.loadPaymentBillData(with: "$\(amount)", type: type)
            delegate?.showQuoteRequestTVC(with: quoteRequestViewController)
        }
    }
}

extension QuoteRequestCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2), height: 50);
    }
}

protocol QuoteRequestCollectionViewControllerConfigurable {
    func showQuoteRequestTVC(with popup : QuoteRequestViewController)
}

extension QuoteRequestCollectionViewControllerConfigurable {
    func showQuoteRequestTVC(with quoteRequestTVC : QuoteRequestViewController) {}
}
