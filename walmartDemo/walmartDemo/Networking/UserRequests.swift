//
//  UserRequests.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation
import UIKit

class UserRequestsManager {
    
    func logginUser(completion: @escaping (LogginResponse?, Error?) -> Void) {
        request(.loggin, genericType: LogginResponse.self, completionHandler: {(logginResponse, error) in
            completion(logginResponse, error)
            }
        )
    }
    
    func signUpUser(completion: @escaping (LogginResponse?, Error?) -> Void) {
        request(.loggin, genericType: LogginResponse.self, completionHandler: {(logginResponse, error) in
            completion(logginResponse, error)
            }
        )
    }
    
    func userInfo(completion: @escaping (User?, Error?) -> Void) {
        request(.userData, genericType: User.self, completionHandler: {(logginResponse, error) in
            completion(logginResponse, error)
            }
        )
    }
    
    func uploadImage(paramName: String, fileName: String, image: UIImage, completionHandler: @escaping(_ result: Bool, Error?) -> Void) {
        let url = URL(string: RequestCases.uploadFile.url)
        let boundary = UUID().uuidString
        let session = URLSession.shared
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = RequestCases.uploadFile.httpMethod.rawValue
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error != nil {
                completionHandler(false, error as Error?)
            } else {
                completionHandler(true, nil)
            }
        }).resume()
    }
    
    
    func request<T: Codable>(_ apiUrl: RequestCases, genericType: T.Type,_ body: [String:Any]? = nil, completionHandler: @escaping(_ result: T?, NSError?) -> Void) {
        if let url = URL(string: apiUrl.url) {
            if let body: [String:Any] = body {
                do {
                    var request = URLRequest(url: url)
                    request.httpMethod = apiUrl.httpMethod.rawValue
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if error != nil {
                            completionHandler(nil, error as NSError?)
                        }else{
                            if let data = data, let response = try? JSONDecoder().decode(T.self, from: data) {
                                completionHandler(response, nil)
                            } else {
                                completionHandler(nil, error as NSError?)
                            }
                        }
                    }.resume()
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil, error as NSError)
                }
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completionHandler(nil, error as NSError?)
                }else{
                    if let data = data, let response = try? JSONDecoder().decode(T.self, from: data) {
                        completionHandler(response, nil)
                    } else {
                        completionHandler(nil, error as NSError?)
                    }
                }
            }.resume()
        }
    }

}
