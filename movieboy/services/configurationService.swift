//
//  configurationService.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import SwiftUI
import OSLog

/// Service for fetching API configuration data
class ConfigurationService {
    /// Fetch the API configuration data. Use it on app startup
    static func initConfig() async throws {
        do {
            let (data, _) = try await ApiHandler.fetchData(url: "https://api.themoviedb.org/3/configuration")
            let decoder = JSONDecoder()
            let configuration = try decoder.decode(Configuration.self, from: data)
            Configuration.instance.images = configuration.images
        } catch {
            Logger().error("\(error.localizedDescription)")
            throw error
        }
    }
}
