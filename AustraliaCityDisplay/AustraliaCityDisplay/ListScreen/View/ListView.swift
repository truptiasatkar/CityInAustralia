//
//  ListView.swift
//  AustraliaCityDisplay
//
//  Created by trupti.asatkar on 18/03/25.
// this class is responsible for shwoing the list of cities

import SwiftUI
struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    @State private var expandedState: String? = nil
    @State var showSplashScreen: Bool = true // Track whether to show the splash screen

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach( viewModel.isReversed ?  viewModel.groupedCities.keys.sorted(by: >) : viewModel.groupedCities.keys.sorted(), id: \.self) { state in
                        Section(header: headerView(for: state)) {
                            sectionContent(for: state)
                        }
                    }
                }
                .navigationTitle(Localization.ListView.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(Localization.ListView.navBarItemTitle) {
                         
                                viewModel.toggleReverse(for: "")
                          
                        }
                       
                    }
                }
                .onAppear {
                    viewModel.loadData()
                }
            }

            // Splash Screen
            if showSplashScreen {
                SplashScreenView()
                    .transition(.opacity) // Smooth transition for splash screen
                    .zIndex(1) // Ensure splash screen stays on top
            }
        }
        .onAppear {
            // Dismiss the splash screen after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplashScreen = false
                }
            }
        }
    }
    
    // Expose expandedState via a computed property
    var currentExpandedState: String? {
        return expandedState
    }

    @ViewBuilder
    func headerView(for state: String) -> some View {
        Button(action: {
            toggleSection(state: state)
        }) {
            HStack(alignment: .top) {
                Text(state)
                    .font(.headline)
                    .foregroundColor(.primary) // Adapts to dark/light mode
                    .lineLimit(nil) // Allow multiple lines
                    .multilineTextAlignment(.leading) // Align text to the left
                    .fixedSize(horizontal: false, vertical: true) // Prevent cropping and allow vertical growth

                Spacer(minLength: 10)

                Image(systemName: expandedState == state ? "chevron.down" : "chevron.right")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    func sectionContent(for state: String) -> some View {
        if expandedState == state {
            ForEach(viewModel.groupedCities[state] ?? []) { city in
                NavigationLink(destination: CityDetails(city: city)) {
                    VStack(alignment: .leading) {
                        Text(city.city)
                            .font(.headline)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Text("Population: \(city.population)")
                            .font(.subheadline)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }

    func toggleSection(state: String) {
        withAnimation {
            expandedState = (expandedState == state) ? nil : state
        }
    }
    
}
