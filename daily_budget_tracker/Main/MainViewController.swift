//
//  mainViewController.swift
//  daily_budget_tracker
//
//  Created by Minseo Cho on 4/16/23.
//

import UIKit
import ParseSwift

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalSpentLabel: UINavigationItem!
    
    private let refreshControl = UIRefreshControl()
    
    private var purchases = [Purchase]() {
        didSet {
            tableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryPosts()
        
        var totalSpentString = totalSpentLabel.title!
        let index = totalSpentString.index(totalSpentString.startIndex, offsetBy: 14)
        totalSpentString.removeSubrange(index...)
        
        if var currentUser = User.current, currentUser.totalSpentToday != nil {
            totalSpentString += String(format: "%.2f", currentUser.totalSpentToday!)
            print("IN THE IF: " + String( currentUser.totalSpentToday!))
        }
        else {
            totalSpentString += "0.00"
        }
        
        
        totalSpentLabel.title! = totalSpentString
    }
    
    private func queryPosts(completion: (() -> Void)? = nil) {
        let todayDate = Calendar.current.date(byAdding: .day, value: (-1), to: Date())!
        let query = Purchase.query()
            .include("user")
            .order([.descending("createdAt")])
            .where("createdAt" >= todayDate)

        query.find { [weak self] result in
            switch result {
            case .success(let purchases):

                self?.purchases = purchases
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
            completion?()
        }

    }

    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    @objc private func onPullToRefresh() {
        refreshControl.beginRefreshing()
        queryPosts { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of \(User.current?.username ?? "current account")?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as? PurchaseCell else {
            return UITableViewCell()
        }
        cell.configure(with: purchases[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate { }
