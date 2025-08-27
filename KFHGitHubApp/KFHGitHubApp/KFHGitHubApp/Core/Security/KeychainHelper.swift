//
//  KeychainHelper.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation
import Security

final class KeychainHelper {
    
    static let shared = KeychainHelper()
    private init() {}
    
    private let service = "com.gadolizm.kfhgithubapp"
    private let account = "GitHubAccessToken"
    
    func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        // Delete old token if exists
        let queryDelete = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        SecItemDelete(queryDelete)
        
        // Add new token
        let queryAdd = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary
        SecItemAdd(queryAdd, nil)
    }
    
    func getToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    func clearToken() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}