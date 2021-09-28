import UIKit
import Generics

class QuoteMakePaymentTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    lazy var button : CustomButton = {
        let button = CustomButton()
        button.isHidden = true
        button.blueButtonWithSystemFontandTittle(withText: "", fontSize: 15)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .blue
        contentView.addSubview(button)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func addConstraints() {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
    }
}

extension QuoteMakePaymentTableViewCell {
    
    func configureCell(withMakePayment quoteMakePaymentViewModel : QuoteMakePaymentConfigurable) {
        guard let quoteMakePayment = quoteMakePaymentViewModel.quoteMakePayment else {
            return
        }
        textLabel?.text = quoteMakePayment.paymentTypeName
        button.isHidden = true
    }
}


protocol QuoteMakePaymentTableViewCellConfigurable {
    var quoteMakePayment : QuoteMakePaymentConfigurable? {get}
}

class QuoteMakePaymentTableViewCellViewModel : QuoteMakePaymentTableViewCellConfigurable {
    var quoteMakePayment: QuoteMakePaymentConfigurable?
    
    init(quoteMakePayment : QuoteMakePaymentConfigurable) {
        self.quoteMakePayment = quoteMakePayment
    }
}

protocol QuoteMakePaymentConfigurable {
    var quoteMakePayment : QuoteMakePayment? {get}
}

class QuoteMakePaymentViewModel : QuoteMakePaymentConfigurable {
    var quoteMakePayment : QuoteMakePayment?
    
    init(quoteMakePayment : QuoteMakePayment) {
        self.quoteMakePayment = quoteMakePayment
    }
}
