//
//  linkView.swift
//  VideoPlayer
//
//  Created by 임준협 on 2023/01/10.
//

import SwiftUI
import AVKit

struct LinkPlayerView: View {
    let inputURL: String
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: URL(string: inputURL)!))
    }
}

struct LinkView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @AppStorage("_viewLink") var viewLink: Bool = false
    @State var url: String = ""
    @State var validLink: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("URL", text: $url)
                        .padding()
                        .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.primary, lineWidth: 3)
                                )
                        .padding(.leading)
                    if url != ""{
                        if validateURL(urlString: url) == false{
                            Button(action: {}, label: {Image(systemName: "play.circle.fill")})
                                .foregroundColor(Color("scheme"))
                                .padding()
                                .background(.secondary)
                                .cornerRadius(15)
                                .padding(.trailing)
                                .disabled(true)
                        } else {
                            Button(action: {
                                validLink.toggle()
                            }, label: {Image(systemName: "play.circle.fill")})
                                .foregroundColor(Color("scheme"))
                                .padding()
                                .background(.primary)
                                .cornerRadius(15)
                                .padding(.trailing)
                        }
                        
                    }else {
                        Button(action: {}, label: {Image(systemName: "play.circle.fill")})
                            .foregroundColor(Color("scheme"))
                            .padding()
                            .background(.secondary)
                            .cornerRadius(15)
                            .padding(.trailing)
                            .disabled(true)
                            
                    }

                    
                        
                }
            }
            .navigationTitle("Stream from link")
            .navigationBarItems(leading: Button(action: {viewLink.toggle()}, label: {
                Image(systemName: "xmark.circle.fill")
                .foregroundColor(.primary)}))
            .navigationBarItems(trailing:NavigationLink(destination: SettingsView(isFirstLaunching: $isFirstLaunching), label: {Image(systemName: "gearshape.fill").foregroundColor(.primary)}))
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
            .fullScreenCover(isPresented: $validLink) {
                LinkPlayerView(inputURL: url)
            }
        }
        
    }
    func validateURL (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView()
    }
}
