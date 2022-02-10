//
//  AccountSummaryViewController.swift
//  Accounts
//
//  Created by Ben Garrison on 2/6/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //Networking Model:
    var userProfile: UserProfile?
    var accounts: [Account] = []
    
    //View Model
    var accountCellViewModel: [AccountSummaryCell.AccountViewModel] = []
    var headerViewModel = AccountSummaryHeaderView.ViewModel(userName: "", date: Date())
    
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        //fetchUserAccountData()
        fetchDataAndLoadView()
    }
    
    private func setupTableView() {
        //tableView.backgroundColor = applicationColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView() //assign to UIView to create NO footer
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModel.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModel[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModel.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    private func fetchUserAccountData() {
//        let savings = AccountSummaryCell.AccountViewModel(accountType: .Banking,
//                                                          accountName: "Basic Savings",
//                                                          balance: 929466.23)
//        let visa = AccountSummaryCell.AccountViewModel(accountType: .Credit,
//                                                       accountName: "Visa Avion Card",
//                                                       balance: 412.83)
//        let chequing = AccountSummaryCell.AccountViewModel(accountType: .Banking,
//                                                           accountName: "No-Fee All-In Chequing",
//                                                           balance: 17562.44)
//        let investment1 = AccountSummaryCell.AccountViewModel(accountType: .Investment,
//                                                              accountName: "Tax-Free Saver",
//                                                              balance: 2000.00)
//        let masterCard = AccountSummaryCell.AccountViewModel(accountType: .Credit,
//                                                             accountName: "Student Mastercard",
//                                                             balance: 50.83)
//        let investment2 = AccountSummaryCell.AccountViewModel(accountType: .Investment,
//                                                              accountName: "Growth Fund",
//                                                              balance: 15000.00)
//
//        accountCellViewModel.append(visa)
//        accountCellViewModel.append(investment1)
//        accountCellViewModel.append(chequing)
//        accountCellViewModel.append(masterCard)
//        accountCellViewModel.append(savings)
//        accountCellViewModel.append(investment2)
    }
}

//MARK: Actions

extension AccountSummaryViewController {
    @objc func logoutButtonTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadView() {
        
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let userProfile):
                self.userProfile = userProfile
                self.configureTableHeaderView(with: userProfile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableHeaderView(with userProfile: UserProfile) {
        let vm = AccountSummaryHeaderView.ViewModel(userName: userProfile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModel = accounts.map {
            AccountSummaryCell.AccountViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
}
