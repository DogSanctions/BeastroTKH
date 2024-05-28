# BeastroTKH

1. BusinessHours.swift
Assumptions:
  - Data Source: The business hours are fetched from a specific URL (https://purs-         demo-bucket-test.s3.us-west-2.amazonaws.com/location.json).
  - Days of the Week: The days of the week are expected to be in a specific format 
    ("MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN").
  - Sorting: Business hours need to be sorted based on the day of the week.
  - Time Format: The start and end times for business hours are in a specific string       format (e.g., "hh:mm:ss").
Design Decisions:
  - Decoding: Uses a custom decoder to parse the JSON response.
  - ViewModel: An observable BusinessHoursViewModel class is used to fetch and store       business hours data.
  - Error Handling: Basic error handling for invalid URLs and JSON decoding issues.
  - Data Sorting: Sorting of business hours based on predefined days of the week.
  - Concurrency: Uses DispatchQueue.main.async to update the UI on the main thread         after fetching data.
3. ContentView.swift
Assumptions:
  - Data Dependency: The ContentView relies on BusinessHoursViewModel for data.
  - UI Elements: Specific UI elements such as the ProgressView, List, and formatting       for business hours display.
Design Decisions:
  - State Management: Uses @StateObject to observe changes in BusinessHoursViewModel.
  - UI Layout: Defines a vertical layout for displaying business hours and handles         various states like loading, error, and displaying data.
  - Reusable UI Components: Utilizes SwiftUI views and custom extensions for corner        radius.
4. JSONDecoder.swift
Assumptions:
  - Response Structure: The JSON response contains a locationName and an array of          hours.
  - Coding Keys: Custom coding keys are defined to map JSON keys to struct properties.
Design Decisions:
  - Decoding Logic: Defines a BusinessHoursResponse struct conforming to Codable for       JSON decoding.
  - Data Model: Clear separation of concerns with a dedicated model for JSON response.
5. PursTKHApp.swift
Assumptions:
  - Main Entry Point: The application starts from the PursTKHApp struct.
  - Scene Management: The app uses a single WindowGroup for managing its UI.
Design Decisions:
  - SwiftUI App Lifecycle: Utilizes the SwiftUI App lifecycle with an @main entry          point.
  - Initial View: Sets ContentView as the initial view of the application.
6. TimeFormatter.swift
Assumptions:
  - Time Format Conversion: Input time is in military (24-hour) format, and it needs       to be converted to 12-hour format.
  - Edge Case Handling: Specific handling for "24:00:00" to be converted to "00:00:00".
Design Decisions:
  - Time Conversion Function: Defines a utility function militaryTo12Converter to          convert time formats.
  - Date Formatting: Uses DateFormatter for parsing and formatting dates.
