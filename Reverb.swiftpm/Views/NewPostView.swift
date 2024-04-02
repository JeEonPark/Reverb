import SwiftUI
import UIKit

struct NewPostView: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var newPostViewModel: NewPostViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showSuccessAlert = false
    
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(hex: 0x1F1D2B)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    ScrollView {
                        VStack (alignment: .leading, spacing: 20) {
                            VStack {
                                HStack {
                                    Text("제목")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Pretendard-Regular", size: 16))
                                        .padding(.top, 20)
                                    Spacer()
                                }
                                TextField("제목을 입력해주세요.", text: $newPostViewModel.title)
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                                    .padding()
                                    .background(Color(hex: 0x3B3654))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            VStack {
                                HStack {
                                    Text("위치")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Pretendard-Regular", size: 16))
                                    Spacer()
                                }
                                TextField("위치을 입력해주세요.", text: $newPostViewModel.location)
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                                    .padding()
                                    .background(Color(hex: 0x3B3654))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            VStack {
                                HStack {
                                    Text("소개")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Pretendard-Regular", size: 16))
                                    Spacer()
                                }
                                TextEditor(text: $newPostViewModel.description)
                                    .transparentScrolling()
                                    .foregroundColor(.white)
                                    .frame(height: 100) // 높이 조절 가능
                                    .padding(10)
                                    .background(Color(hex: 0x3B3654))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            VStack {
                                HStack {
                                    Text("배경 사진 선택")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Pretendard-Regular", size: 16))
                                    Spacer()
                                }
                                if let image = selectedImage { // 이미지가 선택되면 이미지를 표시
                                    VStack {
                                        HStack {
                                            Button(action: {
                                                self.showImagePicker.toggle()
                                            }) {
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: .infinity, height: 180)
                                                    .padding(.vertical)
                                                    .background(Color(hex: 0x3B3654))
                                                    .cornerRadius(8)
                                            }
                                            .sheet(isPresented: $showImagePicker) {
                                                ImagePicker(selectedImage: $selectedImage)
                                            }
                                        }
                                    }
                                } else { // 이미지가 선택되지 않았으면 버튼 표시
                                    VStack {
                                        HStack {
                                            Button(action: {
                                                self.showImagePicker.toggle()
                                            }) {
                                                Text("사진 선택")
                                                    .font(Font.custom("Pretendard-Light", size: 16))
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 30)
                                                    .foregroundColor(.white)
                                                    .padding(.vertical)
                                                    .background(Color(hex: 0x3B3654))
                                                    .cornerRadius(8)
                                            }
                                            .sheet(isPresented: $showImagePicker) {
                                                ImagePicker(selectedImage: $selectedImage)
                                            }
                                        }
                                    }
                                }
                            }
                            VStack {
                                HStack {
                                    Text("음원 선택")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Pretendard-Regular", size: 16))
                                    Spacer()
                                }
                                HStack {
                                    Button(action: {
                                        
                                    }) {
                                        Text("직접 녹음")
                                            .font(Font.custom("Pretendard-Light", size: 16))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 30)
                                            .foregroundColor(.white)
                                            .padding(.vertical)
                                            .background(Color(hex: 0x3B3654))
                                            .cornerRadius(8)
                                    }
                                    Button(action: {
                                        
                                    }) {
                                        Text("파일 선택")
                                            .font(Font.custom("Pretendard-Light", size: 16))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 30)
                                            .foregroundColor(.white)
                                            .padding(.vertical)
                                            .background(Color(hex: 0x3B3654))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            Spacer().frame(height: 100)
                        }
                        
                        Spacer().frame(height: 14)
                    }
                    .padding(.horizontal, 24)
                    VStack {
                        Spacer()
                        Button(action: {
                            uploadNewPost()
                        }) {
                            Text("업로드")
                                .font(Font.custom("Pretendard-Light", size: 18))
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .background(Color(hex: 0x566197))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitleTextColor(.white)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(title: Text("업로드 성공"), message: Text("업로드가 완료되었습니다!"), dismissButton: .default(Text("확인")) {
                self.presentationMode.wrappedValue.dismiss() // 사용자가 확인을 누른 후에 뷰를 닫습니다.
            })
        }
    }
    
    func uploadNewPost() {
        // 이미지 업로드
        if let imageData = selectedImage?.jpegData(compressionQuality: 0.8) {
            newPostViewModel.uploadImage(imageData: imageData) { result in
                switch result {
                case .success(let imageUrl):
                    // 이미지 업로드 성공 시, 포스트 생성
                    createPost(imageUrl: imageUrl)
                case .failure(let error):
                    // 이미지 업로드 실패 시
                    showAlert = true
                    alertMessage = error.localizedDescription
                }
            }
        } else {
            // 이미지가 선택되지 않은 경우
            showAlert = true
            alertMessage = "이미지를 선택하세요."
        }
    }
    
    func createPost(imageUrl: String) {
        let newPost = Post(id: 0, // id는 서버에서 자동으로 할당되므로 임시값으로 0 설정
                           uploader: loginViewModel.username, // 현재 사용자의 이름 또는 ID로 설정
                           title: newPostViewModel.title,
                           location: newPostViewModel.location,
                           description: newPostViewModel.description,
                           upload_datetime: "", // 서버에서 자동으로 생성됨
                           duration: "", // duration 정보가 없는 경우에 대비하여 빈 문자열로 설정
                           comments: [], // 댓글 정보는 처음에 비워둠
                           likes: 0) // 처음에 좋아요 수를 0으로 설정
        
        newPostViewModel.createPost(post: newPost) { result in
            switch result {
            case .success(let createdPost):
                // 포스트 생성 성공 시
                print("Created post: \(createdPost)")
                // 성공적으로 업로드되었다는 메시지를 표시하거나 다른 작업 수행
                self.showSuccessAlert = true
            case .failure(let error):
                // 포스트 생성 실패 시
                showAlert = true
                alertMessage = error.localizedDescription
            }
        }
    }
    
}

class UIImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var selectedImage: UIImage?
    
    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> UIImagePickerCoordinator {
        return UIImagePickerCoordinator(selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        let newPostViewModel = NewPostViewModel()
        let loginViewModel = LoginViewModel()
        
        return NewPostView(viewRouter: viewRouter, newPostViewModel: newPostViewModel, loginViewModel: loginViewModel)
    }
}
