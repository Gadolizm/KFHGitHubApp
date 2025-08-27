//
//  GitHubAuthService.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation
import AuthenticationServices

final class GitHubAuthService: NSObject {
    private var session: ASWebAuthenticationSession?
    
    func login(completion: @escaping (Result<String, Error>) -> Void) {
        let clientId = Secrets.githubClientID
        let callbackURLScheme = "kfhgithubapp"
        
        guard let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=repo") else {
            completion(.failure(AuthError.invalidAuthURL))
            return
        }

        session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: callbackURLScheme
        ) { callbackURL, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let url = callbackURL,
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
                completion(.failure(AuthError.invalidCallback))
                return
            }
            
            completion(.success(code))
        }

        session?.presentationContextProvider = self
        session?.prefersEphemeralWebBrowserSession = true
        session?.start()
    }
}

extension GitHubAuthService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

enum AuthError: Error {
    case invalidAuthURL
    case invalidCallback
}