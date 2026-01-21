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
    
    func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()
            image.draw(in: rect)
        }
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    //Function: Get Image with Fallback
    //Validates URL, downloads image, falls back to "background_1" if invalid or fails
    //imageType parameter reserved for future use (post, comment, group, user)
    func getImageWithFallback(from urlString: String?, imageType: String? = nil) async -> UIImage? {
        // Validate URL string exists and is not empty
        guard let urlString = urlString,
              !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              urlString.lowercased() != "empty",
              urlString.lowercased() != "needgroupimage",
              urlString.lowercased() != "needgroupname" else {
            return UIImage(named: "background_1")
        }
        
        // Validate URL format and scheme
        guard let imageUrl = URL(string: urlString),
              imageUrl.scheme != nil,
              (imageUrl.scheme == "http" || imageUrl.scheme == "https") else {
            print("ImageFunctions: Invalid or unsupported URL -> \(urlString)")
            return UIImage(named: "background_1")
        }
        
        // Attempt to download image
        do {
            let data = try await downloadData(from: imageUrl)
            if let image = UIImage(data: data) {
                return image
            } else {
                print("ImageFunctions: Failed to create UIImage from data for URL: \(urlString)")
                return UIImage(named: "background_1")
            }
        } catch {
            print("ImageFunctions: Error downloading image from \(urlString): \(error)")
            return UIImage(named: "background_1")
        }
    }

}


