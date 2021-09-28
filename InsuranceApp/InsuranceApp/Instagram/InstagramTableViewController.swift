import UIKit

class InstagramTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView  = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InstagramTableViewCell.self, forCellReuseIdentifier: InstagramTableViewCell.reuseIdentifier)
    }
}

// MARK: - Table view data source
extension InstagramTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: InstagramTableViewCell.reuseIdentifier, for: indexPath) as? InstagramTableViewCell
        if cell == nil {
            cell = InstagramTableViewCell(style: .default, reuseIdentifier: InstagramTableViewCell.reuseIdentifier)
        }
        cell?.setupInitialView()
        return cell!
    }
}
