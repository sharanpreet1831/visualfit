 //
//  TransformImageApiCall.swift
//  VisualFit
//
//  Created by student on 03/05/24.
//

import Foundation
import UIKit

func uploadImage(image: UIImage, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    guard let url = URL(string: "https://visual-fit-api.ashusharma.in/api/v1/generate/transformation") else {
        completion(.failure(URLError(.badURL)))
        return
    }
    
    let boundary = UUID().uuidString
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var data = Data()
    guard let imageData = image.pngData() else {
        completion(.failure(UploadError.invalidImageData))
        return
    }
    
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
    data.append(imageData)
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    let session = URLSession.shared
    let task = session.uploadTask(with: urlRequest, from: data) { responseData, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        // print(String(data: responseData!, encoding: .utf8))
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(UploadError.invalidResponse))
            return
        }
        
        if let responseData = responseData {
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] {
                    completion(.success(json))
                } else {
                    completion(.failure(UploadError.invalidJSON))
                }
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(UploadError.noData))
        }
    }
    task.resume()
}

enum UploadError: Error {
    case invalidImageData
    case invalidResponse
    case invalidJSON
    case noData
}


func getImageFromURL(stringURL: String, completion: @escaping (UIImage?) -> Void) {
    if let url = URL(string: stringURL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Error: Invalid image data.")
                completion(nil)
            }
        }
        task.resume()
    } else {
        print("Error: Invalid URL.")
        completion(nil)
    }
}





func uploadTransformImage(originalImage: String, maskImage: String, prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let userInstance = UserData.getInstance()
    let parameters = [
        "prompt":"lose \(userInstance.user.goalDetails.fatLoss!) kg and gain \(userInstance.user.goalDetails.muscleGain!) kg muscle",
        "negative_prompt":"clothes,cartoon,disfigured,blurry,nude",
        "image": originalImage,
        "mask_image": maskImage,
        "model":"realistic-vision-v5-1-inpainting",
        //        "model": "realistic-vision-v1-3-inpainting",
        "seed":10,
        "steps":50,
        "strength":0.8,
        "schedular":"euler",
        "guidance":7,
        "width":768,
        "height":960
    ] as [String: Any?]
    
    do {
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let url = URL(string: "https://api.getimg.ai/v1/stable-diffusion/inpaint")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 1000
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json",
            // harsh api -key
            //            "authorization": "Bearer key-1aDLJpnxSo3yEjQCMw49lk3S1iWuW70It0zEkkzcMC0BDze1kv0N2sEqoMvPutZyyZY1NF82tAB06HJISawhiF8WnNWXrvmL",
            // ashu api -key
            "authorization": "Bearer key-9YQGW94MhOdVrzAuaLaYIQTIP5AeJse50PATVLR7EY0xn19p33vS7p16eaVeTHRk5aIqOiLGq5hiakbiSENaaqxkbgHp64I"
        ]
        request.httpBody = postData
        print("Api calling is going....")
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle network error
                completion(.failure(error))
                return
            }
            print("Api calling is going.... 2")
            if let data = data {
                if let resultString = String(data: data, encoding: .utf8) {
                    // Handle success
                    completion(.success(resultString))
                } else {
                    // Handle invalid data
                    let decodingError = NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode data."])
                    completion(.failure(decodingError))
                }
            } else {
                // Handle no data
                let noDataError = NSError(domain: "NoDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received."])
                completion(.failure(noDataError))
            }
        }.resume()
    } catch {
        // Handle JSON serialization error
        completion(.failure(error))
    }
}


func uploadTransformImage2(originalImage: String, maskImage: String, prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let parameters = [
        "key":"URRQlRO1YpjJ386557f7saWOU4M47gTTBVFJy8hd4YpEwQutKbi09tiFFIqv",
        "prompt":"Loose 5kg body weight of this",
        "init_image": "https://res.cloudinary.com/dvt5ndw4d/image/upload/v1715161298/IMG_0002_zldpky.jpg",
        "mask_image": "https://res.cloudinary.com/dvt5ndw4d/image/upload/v1715161287/IMG_0003_znvhok.jpg",
        "base64": false,
        "width": "512",
        "height": "512",
        "samples": "1",
        //        "model": "realistic-vision-v1-3-inpainting"
    ] as [String: Any?]
    
    do {
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let url = URL(string: "https://modelslab.com/api/v6/image_editing/inpaint")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 1000
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json"
        ]
        request.httpBody = postData
        print("Api calling is going....")
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle network error
                completion(.failure(error))
                return
            }
            //            print("Api response => \(String(data: data!, encoding: .utf8))")
            //            print("Api response 2 \(response)")
            //            print("Api calling is going.... 2")
            if let data = data {
                if let resultString = String(data: data, encoding: .utf8) {
                    // Handle success
                    
                    completion(.success(resultString))
                } else {
                    // Handle invalid data
                    let decodingError = NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode data."])
                    completion(.failure(decodingError))
                }
            } else {
                // Handle no data
                let noDataError = NSError(domain: "NoDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received."])
                completion(.failure(noDataError))
            }
        }.resume()
    } catch {
        // Handle JSON serialization error
        completion(.failure(error))
    }
}
