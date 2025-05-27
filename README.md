# Flutter Web Assessment App

A responsive Flutter web app that demonstrates how to embed and communicate with an HTML iframe using `postMessage`, manage state with `Provider`, and display a simple dashboard with dummy chart data.

## Getting Started

## Prerequisites

- Flutter SDK (3.x or newer)
- A modern browser (Chrome preferred)

## Run the App

flutter run -d chrome

## State Management (Provider)

This project uses provider for state management.

AppStateProvider handles:

Toggling between two iframe views

Listening for messages from the iframe

Storing the latest received message

## iframe Integration

Flutter web doesn't directly support iframe widgets. This project uses:

dart:html → to create the iframe

dart:ui_web → to register a view factory

## postMessage Communication

Communication between the Flutter app and iframe uses postMessage.
Inside iframe_form.html or iframe_static.html.

## Responsive Layout

A custom ResponsiveLayout widget is used to render only one layout depending on screen width using LayoutBuilder.

Breakpoints
Mobile: < 600px

Tablet: 600px – 1023px

Desktop: ≥ 1024px

## Dashboard Implementation

The dashboard displays a chart using dummy data.
library used - fl_chart
