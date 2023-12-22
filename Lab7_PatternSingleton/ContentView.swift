import SwiftUI

class SnowflakeManager {
    static let shared = SnowflakeManager()
    
    private init() {}
    
    func createSnowflake() -> SnowflakeView {
        return SnowflakeView()
    }
}

struct SnowflakeView: View {
    @State private var yPos: CGFloat = -500
    @State private var xPos: CGFloat = CGFloat.random(in: -1000...120)
    @State private var size: CGFloat = CGFloat.random(in: 5...50)
    @State private var opacity: Double = Double.random(in: 0.1...1)
    @State private var fallSpeed: Double = Double.random(in: 1...5)
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "snow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(.white)
                .opacity(opacity)
                .offset(x: xPos, y: yPos)
                .animation(
                    Animation.linear(duration: fallSpeed)
                        .repeatForever(autoreverses: false)
                )
                .onAppear {
                    self.yPos = CGFloat.random(in: -20...0)
                    self.xPos = CGFloat.random(in: 0...500)
                    self.isAnimating = true
                }
                .onChange(of: isAnimating) { _ in
                    if isAnimating {
                        self.animateSnowflake()
                    }
                }
        }
    }
    
    func animateSnowflake() {
        withAnimation {
            self.yPos = 520
        }
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .frame(width: 500, height: 500)
            
            ForEach(0..<100) { _ in
                SnowflakeManager.shared.createSnowflake()
            }
        }
    }
}

@main
struct SnowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(DefaultWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
    }
}
