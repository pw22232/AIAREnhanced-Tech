//
//  team.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//
import SwiftUI

struct TeamRepresentable: View {
    var body: some View {
        
        VStack{
            HStack{Text("Hi, we are the developer team")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
        Spacer()
            
            HStack{
                VStack{ 
                    Spacer()
                    Image("Louie")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150, height: 200)
            
                    
                    Text("Louie")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Spacer()
                   }
                
                VStack{
                    Spacer()
                    Image("Rxc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150,height: 200)
                    
                 
                    Text("Ruoxin Chen")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Spacer()
                  }
            }
            HStack{
                VStack{Image("peter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150,height: 200)
                    
                   
                    Text("Peter Sheehan")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    }
                VStack{Image("zak")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150,height: 200)
                    
                   
                    Text("Zak Mansuri")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    }
            }
        }
    }
}
