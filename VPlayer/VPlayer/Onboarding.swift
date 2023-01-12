import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let secondImage: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .padding()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            HStack{
                Text(subtitle)
                    .font(.title2)
                Image(systemName: secondImage)
            }
        }
        
    }
}
struct OnboardingLastPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    @Binding var isFirstLaunching: Bool
    var body: some View {
        
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 100))
                    .padding()
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text(subtitle)
                    .font(.title2)
//                NavigationLink(destination: ContentView()){
                    Button {
                        
                        isFirstLaunching.toggle()
                        
                    } label: {
                        Text("Start")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                    .padding()
                
//            }
        }
    }
}
struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            OnboardingPageView(
                imageName: "video.fill.badge.checkmark",
                title: "Video Player",
                subtitle: "Slide to start",
                secondImage: "arrow.right"
            )
            
            // 페이지 2: 쓰기 페이지 안내
            OnboardingPageView(
                imageName: "",
                title: "Features",
                subtitle: "",
                secondImage: "arrow.right"
            )
            OnboardingPageView(
                imageName: "externaldrive.fill",
                title: "Watch Video from your directory",
                subtitle: "",
                secondImage: "arrow.right"
            )
            OnboardingPageView(
                imageName: "folder.fill",
                title: "Watch Video directly from your file",
                subtitle: "",
                secondImage: "arrow.right"
            )
            // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
            OnboardingLastPageView(
                imageName: "checkmark.circle.fill",
                title: "All Done!",
                subtitle: "",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
//struct OnboardingTabView_Previews: PreviewProvider {
//    @AppStorage("_isFirstLaunching") var first: Bool = true
//
//    static var previews: some View {
//        OnboardingTabView()
//    }
//}
