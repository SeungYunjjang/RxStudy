
# rxswiftYun
MVVM test 

# 1. rxSwift를 이용하여 MVVM 아키텍쳐를 구현해보는 프로젝트입니다. 

- View ( storyboard / viewcontroller ) <-> ViewModel <-> Model 

- View = 화면 구성은 스토리보드 위주로 구성하고, VC에서 outlet 작업을 진행합니다.

- ViewModel = VC에서 ViewModel을 사용하여, View의 변경을 구현합니다. 

- Model = ViewModel에서 사용할 데이터들을 만들어주는 역활을 합니다. 


# 2. 사용 라이브러리 

- rxswift 
- rxcocoa 
- Alamofire


# 3. swift 파일 설명 
- MvvmTableTestViewController는 View의 역할을 하는 파일이며, 
EndTakeViewModel과 binding하여서 view의 변경을 알려주는 파일입니다.

- EndTakeViewModel은 View의 데이터를 통신을 받아오느 역할이며,
EndTakeModel을 만들어서 items: BehaviorRelay에 넣어주는 역할을 합니다.

- EndTakeModel은 EndTakeViewModel에서 데이터 통시 받은 Json 데이터를 모델화 시켜서
EndTakeCell에서 보다 쉽게 데이터르 사용할 수 있게 해주는 역할입니다.

- EndTakeCell은 tableviewCell으로써, EndTakeModel을 Cell에 보여주는 역할 입니다. 

# 4. HTTP 폴더 설명 

- AlamofireManager는 alamofire를 각 swift 파일에서 import하는 일을 최소화하기 위해 사용합니다. 

- ServerUtil에서는 url과 uri를 정리해놓은 파일입니다. 

- ExRequest에서는 Alamofire를 post와 get 방식의 request를 이용하여,
rxswift에 Observable을 이용하여 데이터 통신 이후의 작업을 실행할 수 있도로 해주는 파일입니다. 



