//
//  ModelList.swift
//  AIAR
//
//  Created by 陈若鑫 on 16/02/2024.
//

import SwiftUI

struct Models {
    let name: String
    let category: String
    let description: String
}

struct ModelViewRepresentable: View {
    
    @State private var models = [
        Models(name:"Model1",category: "IBM Internal",description: "this is model 1, it is an IBM Internal document"),
        Models(name:"Model2",category: "IBM Internal",description: "this is model 2, it is an IBM Internal document"),
        Models(name:"Model3",category: "external",description: "this is model 3, it is an external document"),
        Models(name:"Model4",category: "external",description: "this is model 4, it is an external document"),
        Models(name:"Model5",category: "external",description: "this is model 5, it is an external document")
    ]
    @State private var showModelView = false
    
    func addModel(){
        models.append(Models(name: "newModel", category: "IBM Internal",description: "the model introduction"))
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(models, id:\.name){ (models) in
                    
                    NavigationLink(destination:
                        VStack{
                             Text(models.name)
                             Text(models.category)
                             Text(models.description)
                             Image(models.category)
                                 .resizable()
                                 .frame(width: 200, height: 200)
                         }
                     ){
                        HStack{
                            Image(models.category) .resizable().frame(width: 50, height: 50)
                            Text(models.name)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    models.remove(atOffsets: indexSet)
                })//加给单个item的
                .onMove(perform: { indices, newOffset in
                    models.move(fromOffsets: indices, toOffset: newOffset)
                })//设置位置可移动
            }
            .navigationBarTitle("Models Introduction")
            .navigationBarItems(
                leading: Button(action: {
                    self.showModelView.toggle()
                },
                label: {
                    Text("Add")
                }).sheet(isPresented: $showModelView){
                    AddModelView(showAddModelView: self.$showModelView, models:self.$models)
                },
                trailing: EditButton()
            )
        }
    }
    
    private func addSingleModelview(for model : Models)->some View{
        VStack{
            Text(model.name)
            Text(model.description)
            Image(model.category)
                .resizable()
                .frame(width: 200,height: 200)
        }
    }
}


struct AddModelView: View {
    @Binding var showAddModelView: Bool
    @State private var name: String = ""
    @State private var selectedCategory = 0
    var categoryTypes = ["IBM Internal","external"]
    
    @Binding var models: [Models]
    
    var body: some View {
//        Text("Add new model view")
        
        VStack{
            Text("Add Model Introduction").font(.largeTitle)
            TextField("New model name",text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black).padding()
            Text("Select Category")
            Picker("",selection: $selectedCategory){
                ForEach(0 ..< categoryTypes.count){
                    Text(self.categoryTypes[$0])
                }
            }.pickerStyle(SegmentedPickerStyle())
        }.padding()

        Button(action: {
            self.showAddModelView = false
            models.append(Models(name: name, category: categoryTypes[selectedCategory],description: "model description"))
        },
        label: {
            Text("Done")
        })
    }
}

