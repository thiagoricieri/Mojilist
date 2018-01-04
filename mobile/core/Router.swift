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
    
    static var refeshTokenTries = 0
    
    // Documentation:
    // https://api.dev.bighug.com.br/docs/#authentication
    // .....
    static let baseUrlString = BigHug.app.config.restUrl
    
    // -------------------
    // MARK: - Authentication
    // -------------------
    
    case UserSignUp()
    case UserSignIn(email: String, password: String)
    case UserSignInFacebook(accessToken: String)
    case UserRecovery(email: String)
    case UserUpdate()
    case UserRefreshToken()
    case UserDelete()
    case UserLogout(deviceId: String)
    
    // -------------------
    // MARK: - Me
    // -------------------
    
    case Me()
    case Timeline(page: Int)
    
    // -------------------
    // MARK: - Users
    // -------------------
    
    case Likes()
    case Comments()
    
    // -------------------
    // MARK: - Interests
    // -------------------
    
    case InterestsAll()
    case InterestByUser()
    case InterestSave(interests: Interest.List)
    case InterestRemove(interests: Interest.List)
    
    // -------------------
    // MARK: - Artists
    // -------------------
    
    case ArtistsAll()
    case ArtistProfile(id: String)
    case ArtistTimeline(id: String, page: Int)
    case ArtistFollow(id: String)
    case ArtistUnfollow(id: String)
    case ArtistFollowers(id: String)
    case ArtistFriends(id: String)
    case ArtistAlbums(id: String)
    case ArtistAlbumTracks(id: String)
    case ArtistEvents(id: String)
    case ArtistVideos(id: String, page: Int)
    case ArtistPost(id: String)
    case ArtistByInterests(interests: [String])
    case ArtistFollowMany(artists: [String])
    case ArtistsFollowedByMe()
    case ArtistsSearch(term: String)
    
    // -------------------
    // MARK: - Media
    // -------------------
    
    case MediaSave()
    case MediaLikes(id: String, page: Int)
    case MediaLike(id: String)
    case MediaDelete(id: String)
    case MediaDislike(id: String)
    case MediaComments(id: String, page: Int, highlight: String)
    case MediaComment(id: String, comment: String)
    case MediaCommentOnParent(id: String, parent: String, comment: String)
    case MediaUncomment(id: String, comment: String)
    case Media(withId: String)
    case HugCreate()
    
    // -------------------
    // MARK: - Media
    // -------------------
    
    case Countries()
    case CountriesStates(countryId: String)
    case StatesCity(stateId: String)
    
    // -------------------
    // MARK: - Push Token
    // -------------------
    
    case DeviceTokenRegister(token: String)
    
    // -------------------
    // MARK: - Campaigns
    // -------------------
    
    case CampaignsAll()
    case Campaign(hugId: String)
    case CampaignSearch(term: String)
    case CampaignTimeline(id: String, page: Int)
    
    // -------------------
    // MARK: - Payments
    // -------------------
    
    case PaymentCampaign(payment: [AnyHashable: AnyObject])
    case PaymentSubscription(payment: [AnyHashable: AnyObject])
    
    // -------------------
    // MARK: - Events
    // -------------------
    
    case Event(id: String)
    
    // as URL
    
    func asURLRequest() throws -> URLRequest {
        
        var result: (path: String, method: String, parameters: Dict?) {
            switch self {
                
                // Authentication
                case .UserSignUp():
                    return ("/auth/signup", "POST", nil)
                    
                case .UserSignIn(let email, let password):
                    return ("/auth/login", "POST", [
                        "email": email,
                        "password": password
                    ])
                
                case .UserSignInFacebook(let accessToken):
                    return ("/auth/login", "POST", [
                        "access_token": accessToken,
                    ])
                
                case .UserRecovery(let email):
                    return ("/auth/recovery", "POST", [
                        "email": email
                    ])
                
                case .UserUpdate():
                    return ("/me", "POST", nil)
                
                case .UserRefreshToken():
                    return ("/auth/refresh", "GET", nil)
                
                case .UserDelete():
                    return ("/me", "DELETE", nil)
                
                case .UserLogout(let deviceId):
                    return ("/auth/logout", "POST", [
                        "device_token": deviceId
                    ])
                
                // Me
                case .Me():
                    return ("/me", "GET", nil)
                
                case .Timeline(let page):
                    return ("/me/timeline", "GET", [
                        "page": page
                    ])

                // Users
                case .Likes():
                    return ("/users/likes/", "GET", nil)
                    
                case .Comments():
                    return ("/users/comments/", "GET", nil)
                
                // Interests
                case .InterestsAll():
                    return ("/interests/", "GET", nil)
                    
                case .InterestByUser():
                    return ("/users/interests", "GET", nil)
                    
                case .InterestSave(let interests):
                    return ("/users/interests", "POST", [
                        "interests": interests
                    ])
                    
                case .InterestRemove(let interests):
                    return ("/users/interests", "DELETE", [
                        "interests": interests
                    ])
                    
                // Artists
                case .ArtistsAll():
                    return ("/artists/", "GET", nil)
                
                case .ArtistProfile(let id):
                    return ("/artists/\(id)", "GET", nil)
            
                case .ArtistTimeline(let id, let page):
                    return ("/artists/\(id)/medias", "GET", [
                        "page": page
                    ])
                
                case .ArtistFollow(let id):
                    return ("/artists/\(id)/follow", "POST", nil)
                    
                case .ArtistUnfollow(let id):
                    return ("/artists/\(id)/unfollow", "POST", nil)
                
                case .ArtistFollowers(let id):
                    return ("/artists/\(id)/followers", "GET", nil)
                
                case .ArtistFriends(let id):
                    return ("/artists/\(id)/friends", "GET", nil)
                
                case .ArtistAlbums(let id):
                    return ("/artists/\(id)/albums", "GET", nil)
                
                case .ArtistAlbumTracks(let id):
                    return ("/albums/\(id)", "GET", nil)
                
                case .ArtistEvents(let id):
                    return ("/artists/\(id)/events", "GET", nil)
                
                case .ArtistVideos(let id, let page):
                    return ("/artists/\(id)/videos", "GET", [
                        "page": page
                    ])
                
                case .ArtistPost(let id):
                    return ("/artists/\(id)/medias", "GET", nil)
                
                case .ArtistByInterests(let interests):
                    return ("/artists/by_interests", "POST", [
                        "ids": interests
                    ])
                
                case .ArtistFollowMany(let artists):
                    return ("/artists/follow_many", "POST", [
                        "ids": artists
                    ])
                
                case .ArtistsFollowedByMe():
                    return ("/me/artists/following", "GET", nil)
                
                case .ArtistsSearch(let term):
                    return ("/artists/search/\(term)", "GET", nil)
                
                // Media
                // This route just works for artists
                case .MediaSave():
                    return ("/medias/", "POST", nil)
                
                case .MediaLikes(let id, let page):
                    return ("/medias/\(id)/likes", "GET", [
                        "page": page
                    ])
                
                case .MediaDelete(let id):
                    return ("/medias/\(id)", "DELETE", nil)
                
                case .MediaLike(let id):
                    return ("/medias/\(id)/like", "POST", nil)
                    
                case .MediaDislike(let id):
                    return ("/medias/\(id)/dislike", "POST", nil)
                
                case .MediaComments(let id, let page, let highlight):
                    return ("/medias/\(id)/comments", "GET", [
                        "page": page,
                        "include": highlight
                    ])
                
                case .MediaComment(let id, let message):
                    return ("/medias/\(id)/comment", "POST", [
                        "message": message as AnyObject
                    ])
                
                case .MediaCommentOnParent(let id, let parent, let message):
                    return ("/medias/\(id)/comment", "POST", [
                        "message": message as AnyObject,
                        "parent_id": parent as AnyObject
                    ])

                case .MediaUncomment(let mediaId, let comment):
                    return ("/medias/\(mediaId)/comment/\(comment)", "DELETE", nil)
                
                case .Media(let id):
                    return ("/medias/\(id)", "GET", nil)
                
                case .HugCreate():
                    return ("/hugs/", "POST", nil)
                
                // Countries
                // Countries and states
                case .Countries():
                    return ("/countries", "GET", nil)
                
                case .CountriesStates(let countryId):
                    return ("/countries/\(countryId)/states", "GET", nil)
                
                case .StatesCity(let stateId):
                    return ("/states/\(stateId)/cities", "GET", nil)
                
                // Campaigns
                case .CampaignsAll():
                    return ("/hugs", "GET", nil)
                
                case .Campaign(let hugId):
                    return ("/hugs/\(hugId)", "GET", nil)
                
                case .CampaignSearch(let term):
                    return ("/hugs", "GET", [
                        "search": term
                    ])
                
                case .CampaignTimeline(let id, let page):
                    return ("/hugs/\(id)/medias", "GET", [
                        "page": page
                    ])
                
                case .PaymentCampaign(let payment):
                    return ("/payments", "POST", payment)
                    
                case .PaymentSubscription(let payment):
                    return ("/payments", "POST", payment)
                
                case .Event(let id):
                    return ("/events/\(id)", "GET", nil)
                
                // Token
                case .DeviceTokenRegister(let deviceToken):
                    return ("/me/devices", "POST", [
                        "token": deviceToken,
                        "type": "ios"
                    ])
                
            }
        }
        
        let url = try Router.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpMethod = result.method
        
        if  let x = BigHug.app.bundle.loadToken() {
            urlRequest.setValue("Bearer \(x)", forHTTPHeaderField: "Authorization")
        }
        
        return try JSONEncoding.default.encode(urlRequest,
            with: result.parameters as! Parameters?
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
        
        var headers : HTTPHeaders = [:]//[ "Content-Type": "multipart/form-data; boundary=__X_BIGHUG_BOUNDARY__" ]
        if  let x = BigHug.app.bundle.loadToken() {
            headers["Authorization"] = "Bearer \(x)"
        }
        
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
            if  BigHug.app.isConnected() {
                // Token is invalid?
                if  inBackground.1?.statusCode == 401 {
                    refreshTokenIfNeeded()
                }
                // Token is blacklisted?
                if  inBackground.1?.statusCode == 403 {
                    NotificationBus.post(name: .userForcedToLogOut)
                    return
                }
            }
            
            complete(false, inBackground.2.value)
            return
        }
        
        complete(true, inBackground.2.value)
    }
    
    private func refreshTokenIfNeeded() {
        
        print("")
        print("Refreshing access token...")
        
        Router.refeshTokenTries += 1
        guard Router.refeshTokenTries < 4 else { fatalError("Couldn't refresh Token with API. Tried 3 times") }
        User.refreshToken() { succeed, data in
            if  succeed {
                Router.refeshTokenTries = 0
                if  let data = data as? Dict,
                    let token = data["token"] as? String {
                    BigHug.app.bundle.save(token: token)
                }
            }
        }
    }
    
    func fetchAndEnsure(request: URLRequestConvertible,
                        complete: @escaping OnProcessFinished) {
        
        self.fetch(request: request) {
            t in let ib = (t.request, t.response, t.result)
            self.ensureServerResult(inBackground: ib, request: t.request!, complete: complete)
        }
    }
    
    func prepare(meta oldMeta: MetaPagination?, withDict dict: Dict) -> MetaPagination? {
        
        var meta = oldMeta
        
        // API must sent meta data info
        guard
            let metaTags = dict["meta"] as? Dict,
            let pagination = metaTags["pagination"] as? Dict
        else { fatalError("No meta data sent from API. Can't proceed --> \(dict)") }
        
        // Meta data info must have at least
        // these 3 properties
        guard
            let count = pagination["count"] as? Int,
            let total = pagination["total"] as? Int,
            let currentPage = pagination["current_page"] as? Int
        else { fatalError("Couldn't find count, total or current_page field --> \(pagination)") }
        
        // If there is a meta already set up
        if  var currentMeta = meta {
            // Update
            currentMeta.update(
                count: count,
                total: total,
                currentPage: currentPage
            )
            return currentMeta
        }
        // otherwise...
        else {
            // Can't proceed without total_pages
            guard
                let totalOfPages = pagination["total_pages"] as? Int
            else { fatalError("Couldn't find total_pages field --> \(pagination)") }
            // Create
            meta = MetaPagination(
                count: count,
                total: total,
                currentPage: currentPage,
                totalOfPages: totalOfPages
            )

            return meta
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
