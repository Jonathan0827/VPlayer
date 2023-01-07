//
//  ContentView.swift
//  VideoPlayer
//
//  Created by 임준협 on 2023/01/06.
//
import SwiftUI
import AVKit

struct ContentView: View{
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @State var gradient1 = AngularGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                           center: .topTrailing, angle: .degrees(180+100))
    @State var gradient2 = AngularGradient(gradient: Gradient(colors: [Color.purple, Color.red]),
                                           center: .topTrailing, angle: .degrees(180+100))
    @AppStorage("_viewFolder") var viewFolder: Bool = false
    @AppStorage("_viewFile") var viewFile: Bool = false
    @AppStorage("_directoryName") var dirName: String="unset"
    var body: some View{
        NavigationView{
            VStack{
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                                .fill(gradient2)
                                .hoverEffect(.lift)
                        .frame(width: 340, height: 280)
                    Text("Open File")
                        .font(.title)
                        .fontWeight(.bold)
                }.onTapGesture {
                    viewFile.toggle()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                                .fill(gradient1)
                                .hoverEffect(.lift)
                        .frame(width: 340, height: 280)
                    if dirName == "unset"{
                        Text("Open Directory")
                            .font(.title)
                            .fontWeight(.bold)
                    } else{
                        Text(dirName)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                }.onTapGesture {
                    viewFolder.toggle()
                }
                .padding(.bottom)
                
            }.navigationBarTitle("Welcome")
                .navigationBarItems(trailing:NavigationLink(destination: SettingsView(isFirstLaunching: $isFirstLaunching), label: {Image(systemName: "gearshape.fill").foregroundColor(.primary)}))
                .fullScreenCover(isPresented: $isFirstLaunching) {
                    OnboardingTabView(isFirstLaunching: $isFirstLaunching)
                }
                .fullScreenCover(isPresented: $viewFile) {
                    FileView()
                }.fullScreenCover(isPresented: $viewFolder) {
                    FolderView()
                }
        }
    }
}
struct SelectionView: View{
    var body: some View{
        TabView{
            FolderView()
                .tabItem{
                        Image(systemName: "externaldrive.fill")
                        Text("Folder")
            }
            FileView()
                .tabItem{
                        Image(systemName: "folder.fill")
                        Text("File")
            }
        }.accentColor(.black)
    }
}
struct FolderView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @AppStorage("_directoryName") var dirName: String="unset"
    @AppStorage("_viewFolder") var viewFolder: Bool = false
    @State var showPicker = false
    @State var path:String = ""
    @State var fileContent:String = ""
    var body: some View {
        NavigationView{
            VStack{
                Text(path).padding()
                Button(action: {
                    showPicker.toggle()}, label: {
                        HStack{
                            Image(systemName: "square.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 75, height: 90)
                            VStack(alignment: .leading){
                                Text("Select Folder")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "externaldrive.fill.badge.plus")
                                    .padding(.leading, 1.0)
                            }
                        }.padding()
                            .foregroundColor(Color("scheme"))
                    })
                .background(.primary)
                .cornerRadius(20)
//                    .foregroundColor(Color("scheme"))
                if dirName != "unset"{
                    Button(action: {showPicker.toggle()}, label: {HStack{Image(systemName: "plus.circle.fill");Text("Change Directory")}})
                }
            }
            .navigationTitle("Home")
            .navigationBarItems(leading: Button(action: {viewFolder.toggle()}, label: {
                Image(systemName: "xmark.circle.fill")
                .foregroundColor(.primary)}))
            .navigationBarItems(trailing:NavigationLink(destination: SettingsView(isFirstLaunching: $isFirstLaunching), label: {Image(systemName: "gearshape.fill").foregroundColor(.primary)}))
            .fileImporter(
                isPresented: $showPicker,
                allowedContentTypes: [.folder],
                allowsMultipleSelection: false
            ) { result in
                do {
                    guard let selectedFile: URL = try result.get().first else { return }
                    guard let filePath = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                    path = filePath
                } catch {
                    // Handle failure.
                    print("Unable to read file contents")
                    print(error.localizedDescription)
                }
            }
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
        }
    }
}
struct FileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @AppStorage("_directoryName") var dirName: String="unset"
    @State var showPicker = false
    @State var path:String = ""
    @State var fileContent:String = ""
    @AppStorage("_viewFile") var viewFile: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                Text(path).padding()
                Button(action: {
                    showPicker = true}, label: {
                        HStack{
                            Image(systemName: "square.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 75, height: 90)
                            VStack(alignment: .leading){
                                Text("Select File")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "folder.badge.plus.fill")
                                    .padding(.leading, 1.0)
                            }

                        }.padding()
                            .foregroundColor(Color("scheme"))
                    })
                .background(.primary)
                .cornerRadius(20)
            }
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
            .navigationTitle("Home")
            .navigationBarItems(leading: Button(action: {viewFile.toggle()}, label: {
                Image(systemName: "xmark.circle.fill")
                .foregroundColor(.primary)}))
            .navigationBarItems(trailing:NavigationLink(destination: SettingsView(isFirstLaunching: $isFirstLaunching), label: {Image(systemName: "gearshape.fill").foregroundColor(.primary)}))
            .fileImporter(
                isPresented: $showPicker,
                allowedContentTypes: [.movie],
                allowsMultipleSelection: false
            ) { result in
                do {
                    guard let selectedFile: URL = try result.get().first else { return }
                    guard let filePath = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                    path = filePath
                } catch {
                    // Handle failure.
                    print("Unable to read file contents")
                    print(error.localizedDescription)
                }
            }
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
