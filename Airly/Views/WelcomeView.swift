//
//  WelcomeView.swift
//  Airly
//
//  Created by Elisa Kalil on 27/01/25.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20) {
                Text("Welcome to Airly")
                    .bold().font(.title)
                
                Text("Plase share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}

#Preview {
    WelcomeView()
}
