//
//  ContentView.swift
//  hackclubwebsites
//
//  Created by T Krobot on 8/11/24.
//



import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    let webView: WKWebView
    private let baseURL: URL
    
    init(url: URL) {
        self.baseURL = url
        self.webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func reloadToBaseURL() {
        let request = URLRequest(url: baseURL)
        webView.load(request)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 36/255, green: 38/255, blue: 56/255)
                .ignoresSafeArea()
            
            TabView {
                WebTabView(url: URL(string: "https://bbsshack.club/")!, label: "BBSS Hack Club", systemImage: "house.fill")
                
                WebTabView(url: URL(string: "https://dev.bbsshack.club")!, label: "In progress website!", systemImage: "globe")
                
                WebTabView(url: URL(string: "https://inline-webistes.vercel.app/")!, label: "Websites!", systemImage: "network")
            }
            .accentColor(Color(red: 203 / 255, green: 212 / 255, blue: 245 / 255))
        }
    }
}

struct WebTabView: View {
    let url: URL
    let label: String
    let systemImage: String
    @StateObject private var webViewModel: WebViewModel

    init(url: URL, label: String, systemImage: String) {
        self.url = url
        self.label = label
        self.systemImage = systemImage
        _webViewModel = StateObject(wrappedValue: WebViewModel(url: url))
    }

    var body: some View {
        VStack {
            WebView(webView: webViewModel.webView)
            
            Button(action: {
                webViewModel.reloadToBaseURL()
            }) {
                Label("Go Back", systemImage: "arrow.clockwise")
                    .padding()
                    .background(Color(red: 36/255, green: 38/255, blue: 56/255)
                )
                    .foregroundColor(Color(red: 203 / 255, green: 212 / 255, blue: 245 / 255))
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .tabItem {
            Label(label, systemImage: systemImage)
        }
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No action needed here; reloading is handled in WebViewModel.
    }
}

#Preview {
    ContentView()
}


