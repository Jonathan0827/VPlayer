//
//  settings
//  VideoPlayer
//
//
import SwiftUI

struct SettingsView: View{
    @AppStorage("_directoryName") var dirName: String="unset"

    @Binding var isFirstLaunching: Bool
    @State var showAuthor: Bool = false
    var body: some View{
            Form {
                Button(action: {showAuthor = true}, label: {Text("Who made this?")})
                    .sheet(isPresented: $showAuthor) {
                        AuthorView()
                    }
                Button(action: {isFirstLaunching = true;dirName="unset"}, label: {Text("Reset").foregroundColor(.red)})
            }
            .navigationBarTitle("Settings")
            
    }
}
    
struct AuthorView: View{
    var body: some View{
        NavigationView{
            VStack{
                Image(systemName: "video.fill")
                    .resizable()
                    .frame(width: 100.0, height: 63)
                    
                
                Text("VPlayer")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Label{
                    Text("Made by Jonathan0827")
                } icon:{
                    Image(systemName: "person.crop.circle.fill")
                }
            }.navigationBarTitle("Author")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
