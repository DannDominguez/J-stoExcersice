

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel = UsersListViewModel()
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Profile")
                    .font(.title)
                    .bold()
                    .padding(.top)
                    .offset(CGSize(width: 20, height: 20))
                Spacer()
                Button(action: {
                   viewModel.refreshUserData()
                }) {
                   Text("Get new User")
                        .font(.system(size: 20))
                        .padding(.top)
                        .offset(CGSize(width: -20, height: 20))
                }
            }
            if let user = viewModel.userDetail {
                AsyncImage(url: URL(string: user.results?.first?.picture.large ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let userImage):
                        userImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                            .shadow(color: Color.cyan,radius: 15)
                            .padding(.top)
                        
                    case .failure:
                        Image(systemName: "person.fill")
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(30)
                
                Text("Name: \(user.results?.first?.name?.title ?? "" ). \(user.results?.first?.name?.first ?? "") \(user.results?.first?.name?.last ?? "")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Age: \(user.results?.first?.dob.age ?? Int())")
                Text ("User: \(user.results?.first?.login.username ?? "") ")
                
                Text("Live in: \(user.results?.first?.location?.country ?? ""), \(user.results?.first?.location?.state ?? "")")
                Text("See Location")
                    .bold()
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        let latitude = user.results?.first?.location?.coordinates.latitude
                        let longitude = user.results?.first?.location?.coordinates.longitude
                        let address = "\(user.results?.first?.location?.street?.name ?? "")\(user.results?.first?.location?.street?.number ?? Int())\(user.results?.first?.location?.city ?? "")\(user.results?.first?.location?.country ?? "")\(user.results?.first?.location?.state ?? "")"
                        if let url = URL(string: "http://maps.apple.com/?address=\(address)&ll=\(String(describing: latitude)),\(String(describing: longitude))"){
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                Text("Contact Data")
                    .font(.title2)
                    .bold()
                    .padding(7)
                Text("Email: \(user.results?.first?.email ?? "")")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let email = user.results?.first?.email, let emailURL = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                        }
                    }
                Text("Call Phone: \(user.results?.first?.phone ?? "")")
                    .foregroundColor(.blue)
                    .padding(10)
                    .onTapGesture {
                        guard let phoneNumber = viewModel.userDetail?.results?.first?.phone else { return }
                        guard let phoneURL = URL(string: "tel://\(phoneNumber)") else { return }
                        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                    }
                Text("Send SMS: \(user.results?.first?.cell ?? "")")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let cellPhone = user.results?.first?.cell {
                            let urlStr = "sms://" // Para WhatsApp
                            if let url = URL(string: urlStr) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                ProgressView()
            }
        }
       
        .navigationTitle("Profile")
        Spacer()
            .onAppear {
                viewModel.getUserData()
            }
    }
}


#Preview {
    UsersListView()
}
