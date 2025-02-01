//
//  ContentView.swift
//  GoodLogger-Sample
//
//  Created by Andrej Jasso on 27/08/2024.
//
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
    
    @State private var selectedLogger: LoggerType = .osLog
    @State private var logMessage = ""
    @State private var logLevel: LogLevel = .info
    @State private var privacyType: PrivacyType = .public
    
    private enum LoggerType: String, CaseIterable {
        case osLog = "OSLog"
        case print = "Print"
        case firebase = "Firebase"
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section("Logger Settings") {
                    Picker("Logger Type", selection: $selectedLogger) {
                        ForEach(LoggerType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    Picker("Log Level", selection: $logLevel) {
                        Text("Info").tag(LogLevel.info)
                        Text("Debug").tag(LogLevel.debug)
                        Text("Error").tag(LogLevel.error)
                    }
                    
                    Picker("Privacy", selection: $privacyType) {
                        Text("Public").tag(PrivacyType.public)
                        Text("Private").tag(PrivacyType.private)
                        Text("Sensitive").tag(PrivacyType.sensitive)
                    }
                }
                
                Section("Message") {
                    TextField("Enter log message", text: $logMessage)

                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button("Send Log") {
                            switch selectedLogger {
                            case .osLog:
                                osLogger.log(message: logMessage, level: logLevel, privacy: privacyType)
                            case .print:
                                printLogger.log(message: logMessage, level: logLevel, privacy: privacyType)
                            case .firebase:
                                firebaseLogger?.log(message: logMessage, level: logLevel, privacy: privacyType)
                            }

                            // Clear message after sending
                            logMessage = ""
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(logMessage.isEmpty)

                        Spacer()
                    }
                }
                
                Section("Quick Actions") {
                    Button("Log User Action") {
                        log("User performed action", level: .info)
                    }
                    
                    Button("Log Debug Info") {
                        log("Debug information", level: .debug)
                    }
                    
                    Button("Simulate Error") {
                        log("An error occurred", level: .error)
                    }
                }
            }
            .navigationTitle("GoodLogger Demo")
        }
    }
    
    // MARK: - Helper Methods
    
    private func log(_ message: String, level: LogLevel) {
        switch selectedLogger {
        case .osLog:
            osLogger.log(message: message, level: level, privacy: privacyType)
        case .print:
            printLogger.log(message: message, level: level, privacy: privacyType)
        case .firebase:
            firebaseLogger?.log(message: message, level: level, privacy: privacyType)
        }
    }
}

#Preview {
    ContentView()
}
