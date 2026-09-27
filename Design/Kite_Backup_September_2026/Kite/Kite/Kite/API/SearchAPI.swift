//
//  SearchAPI.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import UIKit


class SearchAPI {
    
    static let shared = SearchAPI()

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func searchFriends(username: String, searchString: String) async throws -> FriendSearchResponseModel {
        print("Search Friends")
        
        let endpoint = "http://localhost:3003/search/user/\(username)/string/\(searchString)/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let friendSearchResponseModel = try decoder.decode(FriendSearchResponseModel.self, from: data)
            
            return friendSearchResponseModel
            
        } catch {
            let friendSearchResponseModel = FriendSearchResponseModel()
            print("Error decoding Friend Search Response data")
            return friendSearchResponseModel
        }
    }

    func searchUsers(searchString: String) async throws -> [SearchUserResult] {
        let data = try await postSearch(path: "/search/users/", searchString: searchString)
        return data.compactMap { item in
            guard let user = item as? [String: Any] else { return nil }
            let userName = stringValue(user["userName"])
            let firstName = stringValue(user["firstName"])
            let lastName = stringValue(user["lastName"])
            let fullName = [firstName, lastName]
                .filter { !$0.isEmpty }
                .joined(separator: " ")
            let name = fullName.isEmpty ? userName : fullName
            guard !name.isEmpty else { return nil }
            return SearchUserResult(name: name, username: userName)
        }
    }

    func searchGroups(searchString: String) async throws -> [SearchGroupResult] {
        let data = try await postSearch(path: "/search/group/", searchString: searchString)
        return data.compactMap { item in
            guard let group = item as? [String: Any] else { return nil }
            let name = stringValue(group["group_name"])
            guard !name.isEmpty else { return nil }
            let owner = stringValue(group["created_by"])
            let detail = owner.isEmpty ? "" : "by \(owner)"
            return SearchGroupResult(title: name, detail: detail)
        }
    }

    private func postSearch(path: String, searchString: String) async throws -> [Any] {
        guard let url = URL(string: "http://localhost:3003" + path) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: ["searchString": searchString])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }

        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let success = json["success"] as? Bool,
            success,
            let results = json["data"] as? [Any]
        else {
            throw networkError.invalidResponse
        }

        return results
    }

    private func stringValue(_ value: Any?) -> String {
        guard let value = value else { return "" }
        if value is NSNull { return "" }
        return String(describing: value).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct SearchUserResult {
    let name: String
    let username: String
}

struct SearchGroupResult {
    let title: String
    let detail: String
}