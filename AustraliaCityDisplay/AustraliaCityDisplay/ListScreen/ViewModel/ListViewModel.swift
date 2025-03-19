//
//  ListViewModel.swift
//  AustraliaCityDisplay
//
//  Created by trupti.asatkar on 18/03/25.
//

import Foundation

// MARK: - ViewModel
class ListViewModel: ObservableObject {
    @Published var expandedState: String? = nil
    @Published var groupedCities: [String: [City]] = [:]
    private var isReversedForState: [String: Bool] = [:] // Tracks reverse state for each section
    private let dataCache: DataCache
    @Published var isReversed : Bool = false
    /// Dependency injection through initializer
    init(dataCache: DataCache = DefaultDataCache()) {
        self.dataCache = dataCache
        loadData()
    }

    func loadData() {
        if let cachedData = dataCache.getCachedData() {
            parseAndGroup(cities: cachedData)
        } else {
            fetchDataFromFile()
        }
    }

    func fetchDataFromFile() {
        // Read file name from Info.plist
        guard let fileName = ConfigManager.getFileName(forKey: Localization.ViewModel.fileName),
              let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print(Localization.ViewModel.missingFile)
            return
        }

        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            dataCache.cacheData(cities: cities)
            parseAndGroup(cities: cities)
        } catch {
            print("Decoding error: \(error)")
        }
    }

    func parseAndGroup(cities: [City]) {
        groupedCities = Dictionary(grouping: cities, by: { $0.adminName })
    }

    func toggleReverse(for state: String) {
        isReversed.toggle()
        groupedCities.reversed()
    }
}
