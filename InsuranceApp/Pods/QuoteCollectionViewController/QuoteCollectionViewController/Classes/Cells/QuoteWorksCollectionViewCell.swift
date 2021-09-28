import UIKit
import Generics
import PopupViewController
import WebKit

class QuoteWorksCollectionViewCell: UICollectionViewListCell {
    
    private lazy var worksDescriptionLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .black)
        label.numberOfLines = 4
        return label
    }()
    private lazy var moreButton : CustomButton = {
        let moreButton = CustomButton()
        moreButton.blueButtonWithSystemFontandTittle(withText: "More", fontSize: 17)
        moreButton.layer.borderWidth = 0.0
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return moreButton
    }()
    var htmlString : String?
    var delegate : QuotesWorksCollectionViewCellConfigurable?
    var popupViewController : PopupViewController?
    var webViewViewModelConfigurable : WebViewViewModelConfigurable?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        contentView.addSubview(worksDescriptionLabel)
        contentView.addSubview(moreButton)
        
        worksDescriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
            make.right.equalTo(contentView).inset(40)
            make.right.equalTo(moreButton.snp.left)
        }
        moreButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.bottom.equalTo(contentView)
        }
    }
    
    func configureCell(with vieModel : QuotesWorksCollectionViewCellConfigurable) {
        guard let model = vieModel.quoteWorksModel else {
            return
        }
        worksDescriptionLabel.text = model.workExplanationData
        htmlString = model.htmlString
    }
    
    @objc private func moreButtonTapped() {
        let webViewModel = WebViewModel(htmlString: htmlString ?? "", buttonTitle: "OK", viewTitle: "How it Works")
        webViewViewModelConfigurable = WebViewViewModel(webViewModel : webViewModel)
        popupViewController = PopupViewController()
        showPopup()
    }
    
    private func showPopup() {
        guard let popup = popupViewController,
              let viewModel = webViewViewModelConfigurable else {
            return
        }
        delegate?.showPopup(with: popup)
        popupViewController?.viewType = .webView(viewModel)
        popupViewController?.delegate?.loadDataInView(with: .webView(viewModel))
        popupViewController?.delegate?.setButton(with: .webView(viewModel))
        popupViewController?.delegate?.setTitle(with: .webView(viewModel))
    }
}

protocol QuotesWorksCollectionViewCellConfigurable {
    var quoteWorksModel : QuoteWorks? {get}
    func showPopup(with popup : PopupViewController)
}

extension QuotesWorksCollectionViewCellConfigurable {
    var quoteWorksModel : QuoteWorks? { return nil }
    func showPopup(with popup : PopupViewController) {}
}

class QuoteWorksCollectionCellViewModel : QuotesWorksCollectionViewCellConfigurable {
    var quoteWorksModel : QuoteWorks?

    init(quoteWorksModel : QuoteWorks) {
        self.quoteWorksModel = quoteWorksModel
    }
}






