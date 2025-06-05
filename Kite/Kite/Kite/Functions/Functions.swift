//
//  Functions.swift
//  Kite
//
//  Created by David Vasquez on 10/19/24.
//

import UIKit

//let postCaption : String = postsArray[0].postCaption ?? ""
func delay(durationInSeconds seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    
}

func printHeader(headerMessage: String) {
    print("______________________________")
    print(headerMessage)
}

func printFooter() {
    print("    ")
    print("______________________________")
    print(" ")
}

//Image Functions
func getImageHeight(image: UIImage) -> CGFloat {
    let aspectRatio = image.size.height / image.size.width
    //let originalImageHeight = image.size.height
    //let originalImageWidth = image.size.width

    let newImageHeight = UIScreen.main.bounds.width * aspectRatio
    //let newImageWidth = UIScreen.main.bounds.width
    
    return newImageHeight
}

func calculateLabelHeight(text: String, font: UIFont = UIFont.systemFont(ofSize: 20), width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = font
    
    let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    
    let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
    let boundingRect = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: textAttributes, context: nil)
    
    return ceil(boundingRect.height)
}

/*
func getImageHeight(currentImage: UIImage) -> Float {
    
    //Get Image Size
    let currentImageHeight = currentImage.size.height
    let currentImageWidth = currentImage.size.width
    print("Image Height \(currentImageHeight) Image Width \(currentImageWidth)")

    //Get Screen
    let screenSize: CGRect = UIScreen.main.bounds
    let phoneWidth = screenSize.width
    print("Screen Width \(phoneWidth) Screen Height \(screenSize.height)")

    //Get Image Size
    let imageCrop = currentImage.getCropRatio()
    //let imageHeight = tableView.frame.width / imageCrop
    let imageHeight = phoneWidth / imageCrop
    let imageWidth = screenSize.width
    
    print("New Image Height \(imageHeight) New Image Width \(imageWidth)")

    print(screenSize)

    return Float(currentImageHeight)
}
*/
/*
Task {
    if let image = await fetchAndReturnImage(from: "http://localhost:3003/images/background_2.png") {
        photoImageView.image = image
    } else {
        print("Failed to load image")
    }
}
*/




/*
 func fetchImage(from urlString: String) async -> UIImage? {
     print("Function: fetchImage trying to get the urlString -> \(urlString)")

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
         print("Error fetching image: \(error.localizedDescription)")
         return nil
     }
 }

 */

/*
 
//fetchImage(from: "http://localhost:3003/images/background_2.png")

func fetchImage(from urlString: String) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }
    
    // Use URLSession to fetch the image data
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching image: \(error)")
            return
        }
        
        guard let data = data, let image = UIImage(data: data) else {
            print("Invalid image data")
            return
        }
        
        // Update the UI on the main thread
        DispatchQueue.main.async {
            self.photoImageView.image = image
        }
    }
    task.resume()
}
*/
