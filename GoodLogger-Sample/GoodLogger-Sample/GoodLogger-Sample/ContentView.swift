//
//  ContentView.swift
//  GoodLogger-Sample
//
//  Created by Andrej Jasso on 27/08/2024.
//

import SwiftUI
import GoodLogger
import Firebase

struct ContentView: View {

    // MARK: - Properties

    private let osLogger = OSLogLogger(logMetaData: true)
    private let printLogger = PrintLogger(logMetaData: true)
    private let firebaseLogger = FirebaseLogger(crashlitics: Crashlytics.crashlytics())

    // MARK: - Body
    
    var body: some View {
        Group {
            Button(action: {
               osLogger.log(message: "Test \(5)")
            }) {
                Text(verbatim: "Send Log OSLog")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .colorInvert()
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.blue, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20.0)
            }

            Button(action: {
                printLogger.log(message: "Test")
            }) {
                Text(verbatim: "Send Log Print Logger")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.green, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .colorInvert()
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.green, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20.0)
            }

            Button(action: {
                firebaseLogger?.log(message: "Test", level: .debug, privacy: .auto)
            }) {
                Text(verbatim: "Send Log Firebase")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .colorInvert()
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.orange, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20.0)
            }

            Button(action: {
                fatalError("Firebase Start")
            }) {
                Text(verbatim: "Crash App")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .colorInvert()
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.red, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20.0)
            }
        }
    }

}

#Preview {
    ContentView()
}
