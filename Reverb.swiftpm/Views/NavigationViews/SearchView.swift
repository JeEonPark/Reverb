import SwiftUI
import MapKit

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 20)
                TextField("Type comment..", text: $searchText, prompt: Text("Search").foregroundColor(.white.opacity(0.15)))
                    .foregroundColor(.white)
                    .frame(height: 10)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(Color(hex: 0x3B3654))
            .cornerRadius(100)
            // 지도 텍스트
            HStack {
                Text("지도에서 찾아보기")
                    .font(Font.custom("Pretendard-Bold", size: 22))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 10)
            // 지도
            MapView()
                .frame(height: 200)
                .cornerRadius(8)
            HStack {
                Text("카테고리로 찾아보기")
                    .font(Font.custom("Pretendard-Bold", size: 22))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 10)
            CategoryList()
                .cornerRadius(8)
            Spacer().frame(height: 60)
        }
        .padding()
    }
}

struct CategoryList: View {
    let categories = [
        "아시아": ["한국", "중국", "일본", "태국", "베트남", "인도", "싱가포르", "말레이시아", "인도네시아", "필리핀", "터키", "사우디아라비아", "이란", "이스라엘", "카타르", "아랍에미리트", "카자흐스탄", "우즈베키스탄"],
        "유럽": ["프랑스", "이탈리아", "독일", "스페인", "영국", "그리스", "네덜란드", "포르투갈", "벨기에", "스웨덴", "스위스", "덴마크", "노르웨이", "오스트리아", "핀란드", "아일랜드", "체코", "폴란드", "헝가리", "루마니아", "크로아티아"],
        "북아메리카": ["미국", "캐나다", "멕시코", "쿠바", "자메이카", "도미니카 공화국", "과테말라", "엘살바도르", "파나마", "코스타리카", "니카라과", "베네수엘라", "콜롬비아", "에콰도르", "페루", "볼리비아", "아르헨티나", "칠레", "우루과이", "파라과이"],
        "남아메리카": ["브라질", "아르헨티나", "칠레", "페루", "볼리비아", "콜롬비아", "베네수엘라", "수리남", "가이아나", "프랑스령 기아나", "에콰도르", "파라과이", "우루과이"],
        "오세아니아": ["호주", "뉴질랜드", "파푸아뉴기니", "피지", "솔로몬 제도", "바누아투", "뉴칼레도니아", "사모아", "통가", "키리바시", "나우루", "미크로네시아", "마샬 제도", "팔라우", "바빈", "마요트", "레위니옹", "프랑스령 폴리네시아", "왈리스 퓌티나"],
        "아프리카": ["나이지리아", "알제리", "이집트", "에티오피아", "남아프리카 공화국", "케냐", "모로코", "수단", "우간다", "가나", "카메룬", "모잠비크", "말리", "짐바브웨", "짐바브웨", "북한", "대한민국", "이라크", "시리아", "인도네시아", "요르단", "레바논", "예멘", "이란", "오만", "카타르", "바레인", "쿠웨이트", "아랍에미리트", "이스라엘", "사우디아라비아", "요르단", "레바논", "시리아", "팔레스타인"]
    ]
    
    let sortedCategories = [
        "아시아", "유럽", "북아메리카", "남아메리카", "오세아니아", "아프리카"
    ]

    var body: some View {
        List {
            ForEach(sortedCategories, id: \.self) { continent in
                if let countries = categories[continent] {
                    Section(header: Text(continent).padding(.top, 8).padding(.bottom, 4)) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .background(Color.clear)
    }
}



struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // 지도 업데이트
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        return SearchView()
    }
}

struct SearchView_PreViews_2: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

