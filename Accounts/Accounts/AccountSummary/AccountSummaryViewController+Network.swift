//
//  AccountSummaryViewController+Network.swift
//  Accounts
//
//  Created by Ben Garrison on 2/9/22.
//

import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct UserProfile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<UserProfile,NetworkError>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/benjygarrison/portfolioFinal/main/Accounts/Accounts/userProfile.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(userProfile))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}

extension AccountSummaryViewController {
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/benjygarrison/portfolioFinal/main/Accounts/Accounts/accountData.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
