//
//  FileView.swift
//  VPlayer
//
//  Created by 임준협 on 2023/01/24.
//

import SwiftUI

struct FileView: View {
    let fileManager = FileManager.default
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
            .navigationTitle("Play with file")
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
                    guard let filePath = String(data: try Data(), encoding: .utf8) else { return }
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
struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        FileView()
    }
}
