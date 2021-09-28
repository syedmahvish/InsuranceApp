import UIKit
import Generics

class IDsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    static let reuseIdentifier: String =  ReuseIdentifierString.idsTableViewCellIdentifier.rawValue
    //static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    var slidesImageView : [UIImageView]?

    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(contentView)
            make.height.equalTo(44)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with idsViewModel : IdsTableViewCellConfigurable) {
        guard let idsModelArray = idsViewModel.idsModelArray else {
            return
        }
        var count  = 0
        slidesImageView = [UIImageView]()
        scrollView.contentSize = CGSize(width: contentView.frame.width * CGFloat(idsModelArray.count), height: contentView.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        for idsModel in idsModelArray {
            let imageView = UIImageView(image: UIImage(named: idsModel.idsImageString ?? ""))
            imageView.frame = CGRect(x: contentView.frame.width * CGFloat(count), y: 0, width: contentView.frame.width, height: contentView.frame.height)
            slidesImageView?.append(imageView)
            scrollView.addSubview(imageView)
            count += 1
        }
        pageControl.numberOfPages = slidesImageView?.count ?? 0
        pageControl.currentPage = 0
    }
    
    static func nibForIdsTableViewCell() -> UINib? {
        let podBundle = Bundle(for: self)
        guard let bundleURL = podBundle.url(forResource: "DashboardTableViewController", withExtension: "bundle"),
              let bundle = Bundle(url: bundleURL)
        else {
            return nil
        }
        return UINib(nibName: "IDsTableViewCell", bundle: bundle)
    }
}

// MARK: - ScrollView Delegates
extension IDsTableViewCell : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/contentView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }    
}


protocol IdsTableViewCellConfigurable {
    var idsModelArray : [IDsModel]? { get }
}

class IdsTableViewCellViewModel : IdsTableViewCellConfigurable {
    var idsModelArray : [IDsModel]?
    
    init(idsModelArray : [IDsModel]?)  {
        self.idsModelArray = idsModelArray
    }
}
