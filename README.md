# AppStore-Rx
Clean Architecture 구조에서 RxSwift, RxCocoa를 사용하여 AppStore를 만들어보자

1. Presentation Layer
	- View:
		애니메이션, 사용자 입력 등 UI 관련 처리
	- Presenter:
		ViewModel, View에 의존적이지 않음
	
	
2. Domain Layer
	- UseCase:
		Entity를 사용하여 비즈니스 로직 구현(업무 요구 사항)
	- Domain Model:
		앱에서 사용하는 실질적인 데이터
	- Translator:
		Entity <-> Domain Model 변환, ViewModel에서 사용할 format
	
	
3. Data Layer
	- Repository:
		UseCase가 필요로 하는 데이터 관련 로직 구현
	- Data Source:
		데이터의 입출력 실행
	- Entity:
		통신 응답 JSON, DB 테이블 데이터


+ "패턴, 구조" 에 따라 Domain Layer 와 Repository는 합쳐져도 상관없음 
+ Data Source도 Repository에서 한번에 수행 가능하면 한번에 수행
+ Domain Model과 Entity와의 차이도 크지 않다면 똑같이 사용해도 괜찮음


참고


https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html


https://medium.com/@justfaceit/clean-architecture%EB%8A%94-%EB%AA%A8%EB%B0%94%EC%9D%BC-%EA%B0%9C%EB%B0%9C%EC%9D%84-%EC%96%B4%EB%96%BB%EA%B2%8C-%EB%8F%84%EC%99%80%EC%A3%BC%EB%8A%94%EA%B0%80-1-%EA%B2%BD%EA%B3%84%EC%84%A0-%EA%B3%84%EC%B8%B5%EC%9D%84-%EC%A0%95%EC%9D%98%ED%95%B4%EC%A4%80%EB%8B%A4-b77496744616


https://eunjin3786.tistory.com/207
