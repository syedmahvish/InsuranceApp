import UIKit

class CustomDropDownCell: UITableViewCell {
    
    @IBOutlet weak var stateNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stateNameLabel.layer.borderWidth = 1
        stateNameLabel.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
