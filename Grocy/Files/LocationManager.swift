//
//  LocationManager.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//
import Foundation
import CoreLocation


@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var location: CLLocation?
    var address: String = "Locating..."
    var lastGeocodedLocation: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }

        if let lastLocation = self.location, newLocation.distance(from: lastLocation) < 100 {
            self.location = newLocation
            return
        }

        Task { @MainActor in
            self.location = newLocation
            await self.reverseGeocode(location: newLocation)
            self.lastGeocodedLocation = newLocation
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor in
            self.address = "Location not Found"
        }
    }

    private func reverseGeocode(location: CLLocation) async {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let parts = [placemark.locality, placemark.administrativeArea]
                let fullAddress = parts.compactMap { $0 }.joined(separator: ", ")
                await MainActor.run {
                    self.address = fullAddress
                }
            }
        } catch {
            await MainActor.run {
                self.address = "Failed to get address"
            }
        }
    }
}
