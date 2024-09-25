import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ProductCellViewModel
    @State private var isDetailExpanded: Bool = false
    @State private var navigateToCart = false
    
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
                    
                    AsyncImage(url: URL(string: viewModel.product.img)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                    } placeholder: {
                        ProgressView()
                    }
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
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(viewModel.isFavorite ? .red : .secondaryText)
                    }
                    
                    Text("\(viewModel.product.stock ?? "") pcs, price")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        if viewModel.showQuantity {
                            //                        IncrementDecrementButton(viewModel: viewModel)
                            Button {
                                viewModel.decrementQuantity()
                            } label: {
                                Image("Vector-5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .foregroundColor(Color.secondaryText)
                            
                            Text("\(viewModel.cartQuantity)")
                                .font(.customfont(.semibold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45, alignment: .center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                                )
                            
                            Button {
                                viewModel.incrementQuantity()
                            } label: {
                                Image("Vector-6")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
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
                                        .frame(width: 15, height: 15)
                                    
                                    Text("Add to Basket")
                                        .font(.customfont(.semibold, fontSize: 14))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                            }
                            .frame(width: 150, height: 45)
                            .background(Color.primaryApp)
                            .cornerRadius(15)
                        }
                        Spacer()
                        Text("$\(viewModel.product.price, specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                    }
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack {
                    HStack {
                        Text("Product detail")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            withAnimation {
                                isDetailExpanded.toggle()
                            }
                        } label: {
                            Image("Vector-7")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if isDetailExpanded {
                        Text(viewModel.product.description ?? "No description available.")
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .padding(.bottom, 8)
                        
                    }
                    
                   
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(20)
            }
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
//                    Button {
//                        mode.wrappedValue.dismiss()
//                    } label: {
//                        Image("Vector-4")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 25, height: 25)
//                    }
                }
                
                Spacer()
                
                NavigationLink(
                    destination: MyCartView()
                    .environmentObject(viewModel),
                    isActive: $navigateToCart
                ) {
                    RoundButton(title: "Go To Cart", didTap: {
                      
                        navigateToCart = true
                    })
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
                }
                
//                
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}
