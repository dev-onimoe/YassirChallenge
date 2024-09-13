//
//  SwiftUIView.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 13/09/2024.
//

import SwiftUI

struct SwiftUIView: View {
    
    var closure : (() -> Void)?
    let character : Character?
    
    var body: some View {
        VStack(spacing: 12) {
            
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: character?.image ?? "")) { image in
                    
                    
                    image.image?.resizable()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 350)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .aspectRatio(contentMode: .fill)
                   
                
                Button(action: {
                   closure!()
                }, label: {
                    Image(systemName: "arrow.left")
                        .tint(.black)
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(.white))
                        .padding(.top, 40)
                        .padding(.leading, 15)
                        .cornerRadius(25)
                })
            }.frame(maxWidth: .infinity, maxHeight: 350)
            
            HStack(spacing: 12) {
                
                Text(character?.name ?? "")
                    .padding(.leading, 16)
                    .font(.custom("Roboto-Bold", size: 24))
                Spacer()
                Text(character?.status ?? "")
                    .frame(width: 100, height: 40)
                    .background(Color(uiColor: UIColor(red: 31/255, green: 206/255, blue: 249/255, alpha: 1)))
                    .cornerRadius(20.0)
                    .padding(.trailing, 16)
                    .font(.custom("Roboto-Regular", size: 16))
            }
            
            HStack(spacing: 8) {
                
                Text(character?.species ?? "")
                    .padding(.leading, 16)
                Text("•")
                Text(character?.gender ?? "")
                Spacer()
            }
            
            Spacer().frame(height: 16)
            
            HStack(spacing: 12) {
                
                Text("Location")
                    .padding(.leading, 16)
                    .font(.custom("Roboto-Medium", size: 16))
                Text(":")
                Text(character?.location.name ?? "")
                Spacer()
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SwiftUIView(character: nil)
}

