//
//  ModelViewList.swift
//  AIAR
//
//  Created by 陈若鑫 on 16/02/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore



struct Models {
    //use document ID as the identifier in firebase
    @DocumentID var id: String?
    var name: String
    var category: String
    var description: String
}


struct ModelListView: View {
    // the frontend of the main model intro page
    //use viewModel to fetch data from firebase
 
    @ObservedObject private var viewModel = ModelsViewModel()
    @State private var showModelView = false

    //use locally
    /*func addModel(){
        models.append(Models(name: "newModel", category: "IBM Internal",description: "the model introduction"))
    }*/
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.models, id:\.name){ (models) in
                    
                    NavigationLink(destination:
                        VStack{
                             Text(models.name)
                            .font(.title)
                            .padding(.bottom, 5)
                        
                             Text(models.category)
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                             Text(models.description)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: .infinity, alignment: .topLeading) // 调整尺寸和对齐
                            .background(Color(UIColor.systemBackground)) // 背景色
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10) // 圆角矩形边框
                                                   .stroke(Color.gray, lineWidth: 1) // 边框颜色和宽度
                                           )
                                           .padding(.horizontal) // 给屏幕两侧留出空间
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
                //use the method in viewModel, also delete the data in firebase
                .onDelete(perform: { indexSet in
                    viewModel.removeModels(atOffsets: indexSet)
                })//加给单个item的 use
                .onMove(perform: viewModel.moveModel)//设置位置可移动 Set movement
            }
            .navigationBarTitle("Models Introduction")
            .navigationBarItems(
                leading: Button(action: {
                    self.showModelView.toggle()
                },
                label: {
                    Text("Add")
                }).sheet(isPresented: $showModelView){
                    AddModelView(viewModel: viewModel, showAddModelView: $showModelView)
                },
                trailing: EditButton()
            )
        }
    }
    
    //use locally
   /* private func addSingleModelview(for model : Models)->some View{
        VStack{
            Text(model.name)
            Text(model.description)
            Image(model.category)
                .resizable()
                .frame(width: 200,height: 200)
        }
    }*/
    
}


struct AddModelView: View {
    var viewModel: ModelsViewModel
    @Binding var showAddModelView: Bool
    @State private var name: String = ""
    @State private var description : String = ""
    @State private var selectedCategory = 0
    var categoryTypes = ["IBM Internal","external"]
    
    var body: some View {
        VStack{
            Text("Add Model Introduction").font(.largeTitle)
            TextField("New model name",text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black).padding()
            TextField("New model description",text: $description)
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
            let newModel = Models(name: name, category: categoryTypes[selectedCategory],description: description)
            self.addModelsToFireStore(model: newModel)
        },
        label: {
            Text("Done")
        })
    }
    
    
    //save the data in firebase
    func addModelsToFireStore(model:Models){
        let db = Firestore.firestore()
        db.collection("models").addDocument(data: ["name": model.name, "category": model.category,"description": model.description]){
            error in
            if error != nil{
                print ("Error adding document")
            }else{
                print("Document added successful")
            }
        }
    }
}




//initiate model class
class ModelsViewModel: ObservableObject{
    @Published var models = [Models]()
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        let db = Firestore.firestore()
        db.collection("models").addSnapshotListener{(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else{
                print("Error fetching documents: \(error!)")
                return
            }
            let models = documents.map{queryDocumentSnapshot -> Models in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let description = data ["description"] as? String ?? ""
                return Models(id: queryDocumentSnapshot.documentID, name: name, category: category, description: description)
            }
            
            DispatchQueue.main.async {
                self.models = models
            }
        }
    }
   /* func addModel(model: Models){
        let db = Firestore.firestore()
        do{
            _ = try db.collection("models").addDocument(from: model)
        }catch{
            print (error)
        }
    }*/
    
    func moveModel(from source: IndexSet, to destination: Int) {
        //update local arrat to make new sequence
        // 更新本地 models 数组以反映新的顺序
        models.move(fromOffsets: source, toOffset: destination)
        
    }
    
    func removeModels(atOffsets offsets: IndexSet){
        let db = Firestore.firestore()
        offsets.forEach{
            index in
            let model = models[index]
            if let documentId = model.id{
                db.collection("models").document(documentId).delete{error in
                    if error != nil{
                        print("Error removing document : \(error)")
                    }else{
                        self.fetchData()
                    }
                        
                }
            }else{
                print("Document Id is nil. cannot delete the document ")
            }
        }
    }
}
