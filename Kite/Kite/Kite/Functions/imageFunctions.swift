//
//  imageFunctions.swift
//  Kite
//
//  Created by David Vasquez on 5/28/25.
//


import UIKit
 

class ImageFunctions {
    
    //Function: Download Data
    func downloadData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func fetchImage(from urlString: String) async -> UIImage? {
        //print("Function: fetchImage trying to get the urlString \(urlString)")
        guard let url = URL(string: urlString) else {
            print("Functions: fetchImage-> Invalid URL \(urlString)")
            return nil
        }
        
        // Check if the URL is empty or invalid
        guard !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Error: URL string is empty")
            return nil
        }

        // Ensure the URL is properly formed
        guard let url = URL(string: urlString), url.scheme != nil else {
            print("Error: Invalid or unsupported URL -> \(urlString)")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Error fetching image: \(error)")
            return nil
        }
    }

    
}


