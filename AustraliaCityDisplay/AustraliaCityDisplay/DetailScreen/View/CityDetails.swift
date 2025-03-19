//
//  CityDetails.swift
//  AustraliaCityDisplay

// This class is responsible to show deatils of city
import SwiftUI

struct CityDetails: View {
    var city: City

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: Localization.CityDetail.locationIcon)
                Text("Latitude: \(city.lat), Longitude: \(city.lng)")
                    .lineLimit(nil)
            }
            HStack {
                Image(systemName: Localization.CityDetail.flagIcon)
                Text("Country: \(city.country)")
                    .lineLimit(nil)
            }
            HStack {
                Image(systemName: Localization.CityDetail.populationIcon)
                Text("Population: \(city.population)")
                    .lineLimit(nil)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .navigationTitle(city.city)
        .navigationBarBackButtonHidden(false) // Ensures back button is displayed
    }
}

// MARK: - CityDetailView_Previews
struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetails(city: City(
            city: "Sydney",
            adminName: "New South Wales",
            population: "4840600",
            lat: "-33.8678",
            lng: "151.2100",
            country: "Australia",
            iso2: "AU",
            capital: "admin",
            populationProper: "4840600"
        ))
    }
}
