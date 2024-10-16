import SwiftUI
import Firebase

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ProductCellViewModel
    @State private var categoryName: String = ""
    @State private var productsInCategory: [Product] = []
    @State private var isDetailExpanded: Bool = false
    @State private var navigateToCart = false
    @State private var navigateToAllProducts = false
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    init(viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                    
                    TabView {
                        ForEach(viewModel.product.images ?? [""], id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                VStack {
                    HStack {
                        Text(viewModel.product.name)
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            viewModel.toggleFavorite()
                        } label: {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .foregroundColor(viewModel.isFavorite ? .red : .secondaryText)
                    }
                    
                    
                    Text("\(viewModel.product.stock ?? "")")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    
                    Spacer()
                    Spacer()
                    
                    HStack {
                        if viewModel.showQuantity {
                            
                            Button {
                                viewModel.decrementQuantity()
                            } label: {
                                Image("Vector-5")
                                //                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                                //                                    .overlay(
                                //                                        RoundedRectangle(cornerRadius: 16)
                                //                                            .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                                //                                    )
                            }
                            .foregroundColor(Color.secondaryText)
                            
                            Text("\(viewModel.cartQuantity)")
                                .font(.customfont(.semibold, fontSize: 22))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                                )
                            
                            Button {
                                viewModel.incrementQuantity()
                            } label: {
                                Image("Vector-6")
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                                //                                    .overlay(
                                //                                        RoundedRectangle(cornerRadius: 16)
                                //                                            .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                                //                                    )
                            }
                            .foregroundColor(Color.secondaryText)
                            
                        } else {
                            Button {
                                viewModel.addProductToCart()
                            } label: {
                                HStack {
                                    Image("Vector-3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10, height: 10)
                                    
                                    Text("Add to Basket")
                                        .font(.customfont(.semibold, fontSize: 12))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                            }
                            .frame(width: 120, height: 40)
                            .background(Color.primaryApp)
                            .cornerRadius(15)
                        }
                        Spacer()
                        Text("Rs \(viewModel.product.price, specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    Spacer()
                    Spacer()
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                
                VStack(alignment: .leading) {
                   
                    Text("Product Detail")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .padding(.top, 10)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                   
                    Text(viewModel.product.description!)
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .padding(.top, 5)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                }
                    Divider()
                        .padding(.horizontal, 20)
                
                    
                
                    HStack {
                     
                        Text("Nutrition")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryText)
                            .padding(.top, 10)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                      
                      
                        Text(viewModel.product.nutritions ?? " ")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .padding(.top, 5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 20)
                    }
                    
                   
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                
//                VStack(alignment: .leading) {
//                            Text("Top Products in \(categoryName)")
//                                .font(.customfont(.semibold, fontSize: 18))
//                                .foregroundColor(.primaryText)
//                                .padding(.top, 10)
//
//                            // Display Products in the Category
//                            ScrollView(.vertical, showsIndicators: true) {
//                                LazyVGrid(columns: columns, spacing: 20) { // Use LazyVGrid for grid layout
//                                    ForEach(productsInCategory) { product in
//                                        ProductCellAll(product: product) // Your ProductCellAll here
//                                    }
//                                }
//                                .padding(.horizontal)
//                                .padding(.top, 10)
//                            }
//                            .padding(10)
//                            .background(Color.white.opacity(0.1)) // Optional: Set the background color
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                        }
//                        .padding(.horizontal)
            }
            
            .padding(.bottom, 20)
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                        
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.primaryApp)
                    }
                    
                    Spacer()
                    NavigationLink(
                        destination: AllProducts(),
                        isActive: $navigateToAllProducts
                    ) {
                        Button {
                            navigateToAllProducts = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                            
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.primaryApp)
                        }
                    }
                }
                
                Spacer()
                
                if viewModel.showQuantity {
                    NavigationLink(
                        destination: MyCartView(showBackButton: true)
                            .environmentObject(viewModel),
                        isActive: $navigateToCart
                    ) {
                        RoundButton(title: "Go To Cart", didTap: {
                            navigateToCart = true
                        })
                        .padding(.horizontal, 20)
                        .padding(.bottom, .bottomInsets + 30)
                    }
                }
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            fetchCategoryNameAndProducts()
            
            viewModel.fetchCartQuantity()
        }
    }
    
    private func fetchCategoryNameAndProducts() {
        guard let categoryID = viewModel.product.categoryID else { return }
        
        let db = Firestore.firestore()
        
        
        db.collection("categories").document(categoryID).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let category = try document.data(as: Category.self)
                    categoryName = category.name ?? "Unknown Category"
                } catch {
                    print("Error decoding category: \(error)")
                }
            } else {
                print("Category does not exist")
            }
        }
        
        
        db.collection("products").whereField("categoryID", isEqualTo: categoryID).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching products in category: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No products found for this category.")
                return
            }
            
            
            self.productsInCategory = documents.compactMap { document in
                try? document.data(as: Product.self)
            }
        }
    }
    
}
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
       
        let sampleProduct = Product(
            id: "sample_id",
            name: "Sample Product",
            price: 29.99, description: "This is a sample product description.", img: "https://via.placeholder.com/150",
            stock: "5 gram"
        )
        
        let sampleViewModel = ProductCellViewModel(product: sampleProduct)
        
        ProductDetailsView(viewModel: sampleViewModel)
            .preferredColorScheme(.light)
    }
}
