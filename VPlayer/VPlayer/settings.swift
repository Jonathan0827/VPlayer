//
//  settings
//  VideoPlayer
//
//
import SwiftUI

struct SettingsView: View{
    @AppStorage("_directoryName") var dirName: String="unset"
    @AppStorage("_viewFolder") var viewFolder: Bool = false
    @AppStorage("_viewFile") var viewFile: Bool = false
    @Binding var isFirstLaunching: Bool
    @AppStorage("_showAuthor") var showAuthor: Bool = false
    @State var reset: Bool = false
    var body: some View{
            Form {
                Button(action: {showAuthor = true}, label: {Text("Who made this?")})
                    .sheet(isPresented: $showAuthor) {
                        AuthorView()
            }
                Button(action: {isFirstLaunching.toggle();dirName="unset";viewFile=false;viewFolder=false;reset.toggle()}, label: {Text("Reset").foregroundColor(.red)})
            }.onAppear(perform: {showAuthor=false})
            .fullScreenCover(isPresented: $reset){
                ContentView()
            }
            .navigationBarTitle("Settings")
            
    }
}
    
struct AuthorView: View{
    @AppStorage("_showAuthor") var showAuthor: Bool = true
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
                .navigationBarItems(trailing: Button(action: {showAuthor=false}, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.primary)
                        .padding(.top, 100.0)
                        
            }))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
