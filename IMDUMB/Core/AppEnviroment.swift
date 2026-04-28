//
//  AppEnviroment.swift
//  IMDUMB
//
//  Created by Derly on 28/04/26.
//

enum AppEnvironment {

    static var baseURL: String {
        #if STAGING
        return "https://api.themoviedb.org/3/staging" // ejemplo
        #elseif RELEASE
        return "https://api.themoviedb.org/3/release"
        #else
        return "https://api.themoviedb.org/3" // DEBUG
        #endif
    }

    static var name: String {
        #if STAGING
        return "Staging"
        #elseif RELEASE
        return "Production"
        #else
        return "Debug"
        #endif
    }

    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
