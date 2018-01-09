//
//  Router.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import Alamofire
import HTTPStatusCodes

// MARK: - Router
enum Router: URLRequestConvertible {
    
    static let baseUrlString = ""
    
    // -------------------
    // MARK: - Me
    // -------------------
    
    case Me()
    
    // as URL
    func asURLRequest() throws -> URLRequest {
        
        var result: (path: String, method: String, parameters: Dict?) {
            switch self {
                // Me
                case .Me():
                    return ("/me", "GET", nil)
            }
        }
        
        let url = try Router.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpMethod = result.method
        
        return try JSONEncoding.default.encode(urlRequest,
                                               with: result.parameters as Parameters?
        )
    }
}

// MARK: - API
public class Api {

    static let shared = Api()
    
    class func getError(_ result: Any?, invalidResult: String) -> String {
        guard let data = result as? Dict else {
            return invalidResult
        }
        if let errors = data["errors"] as? [[String]] {
            return errors[0][0]
        }
        if let message = data["message"] as? String {
            return message
        }
        return invalidResult
    }
    
    func fetch(request: URLRequestConvertible,
               complete: @escaping InBackgroundResponse) {
        
        debug(request: request)
        
        Alamofire
            .request(request)
            .debugLog()
            .responseJSON(
                queue: nil,
                options: .allowFragments,
                completionHandler: complete
            )
    }
    
    func fetch(request: URLRequestConvertible,
               upload: ((MultipartFormData) -> Void)?,
               complete: @escaping OnProcessFinished) {
        
        let headers : HTTPHeaders = [:]
        if let multipart = upload {
            
            print("⏫ Headers: \(headers)")
            print("⏫ Path: \(request.urlRequest!.url!.absoluteString)")
            
            Alamofire.upload(
                multipartFormData: multipart,
                usingThreshold: UInt64.init(),
                to: request.urlRequest!.url!.absoluteString,
                method: .post,
                headers: headers,
                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload
                            .debugLog()
                            .responseJSON(queue: nil, options: .allowFragments) {
                            t in let inBackground = (t.request, t.response, t.result)
                            
                            self.debug(response: inBackground)
                            
                            guard
                                inBackground.2.isSuccess,
                                let status = inBackground.1?.statusCodeValue,
                                status.isSuccess || status.isInformational
                            else {
                                complete(false, inBackground.2.value)
                                return
                            }
                            
                            complete(true, inBackground.2.value)
                        }
                    case .failure(_):
                        print("[Api] Failed encoding")
                        complete(false, nil)
                    }
                }
            )
        }
        else {
            debug(request: request)
            self.fetchAndEnsure(request: request, complete: complete)
        }
    }
    
    func ensureServerResult(inBackground: InBackgroundTuple,
                            request: URLRequestConvertible,
                            complete: @escaping OnProcessFinished) {
        
        debug(response: inBackground)
        
        guard
            inBackground.2.isSuccess,
            let status = inBackground.1?.statusCodeValue,
            status.isSuccess || status.isInformational
        else {
            
            // Refresh Token
//            if  BigHug.app.isConnected() {
//                // Token is invalid?
//                if  inBackground.1?.statusCode == 401 {
//                    refreshTokenIfNeeded()
//                }
//                // Token is blacklisted?
//                if  inBackground.1?.statusCode == 403 {
//                    NotificationBus.post(name: .userForcedToLogOut)
//                    return
//                }
//            }
            
            complete(false, inBackground.2.value)
            return
        }
        
        complete(true, inBackground.2.value)
    }
    
    func fetchAndEnsure(request: URLRequestConvertible,
                        complete: @escaping OnProcessFinished) {
        
        self.fetch(request: request) {
            t in let ib = (t.request, t.response, t.result)
            self.ensureServerResult(inBackground: ib, request: t.request!, complete: complete)
        }
    }
    
    public func debug(request: URLRequestConvertible) {
        
        if  let r = request.urlRequest,
            let params = r.httpBody {
            print("")
            print("🥊 REQUEST Parameters: \(String(describing: String(data: params, encoding: .utf8)))")
            print("")
        }
    }
    
    public func debug(response: InBackgroundTuple) {
        print("")
        print("✨ RESPONSE: \(String(describing: response.1?.statusCode))")
        print("Path: \(String(describing: response.0?.httpMethod!)) \(String(describing: response.0?.url?.absoluteString))")
        print("Headers: \(String(describing: response.1?.allHeaderFields))")
        print("Response: \(response.2): \(String(describing: response.2.value)) (\(String(describing: response.2.error)))")
        print("")
    }
}

public extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            print("")
            print("... 🚀 Request: \(String(describing: self.request?.url?.absoluteString))")
            debugPrint(self)
            print("")
        #endif
        return self
    }
}
