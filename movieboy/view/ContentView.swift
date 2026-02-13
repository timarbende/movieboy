//
//  ContentView.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import SwiftUI

struct ContentView: View {
    /// whether or not the app is done with initialization
    @State var loaded = false
    @State var moviewPath = NavigationPath()
    @State var showsPath = NavigationPath()
    @State var favouritesPath = NavigationPath()
    @State var activeTab = 0
    
    /// favouritesViewModel passed down to enable favouriting
    @State var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        if !loaded {
            SplashScreen().task {
                try? await ConfigurationService.initConfig()
                try? await Task.sleep(nanoseconds: 2500000000)
                loaded = true
            }
        } else {
            TabView(selection: $activeTab) {
                PopularsPage(
                    mediaType: MediaType.Movie,
                    path: $moviewPath,
                    favouritesViewModel: favouritesViewModel)
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
                .onAppear {
                    moviewPath = NavigationPath()
                }
                .id(UUID())
                PopularsPage(
                    mediaType: MediaType.Show,
                    path: $showsPath,
                    favouritesViewModel: favouritesViewModel)
                .tabItem {
                    Label("Shows", systemImage: "tv")
                }
                .onAppear {
                    showsPath = NavigationPath()
                }
                .id(UUID())
                FavouritesPage(
                    favouritesViewModel: favouritesViewModel,
                    path: $favouritesPath)
                .tabItem {
                    Label("Favourites", systemImage: "star.circle")
                }
                .onAppear {
                    favouritesPath = NavigationPath()
                }
                .id(UUID())
            }
        }
    }
}
