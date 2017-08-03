
필수 요구사항
* 마감일 8/4
* Github PR 을 만들어서 commit, push (수시로 code review)
* MVC Pattern
* 게시물 목록
    * 데이터 변경에 반응하여 View 갱신
    * 내용, 작성 시간, 댓글 수 표시
* 게시물 작성
    * 작성 후 목록으로 이동
* 게시물 상세
    * 상단에 게시물 내용 표시
* DataStore (이름은 스스로 정함)
    * singleton
    * 모든 데이터를 관리함, 가상의 데이터 베이스
    * 게시물 생성, 삭제
    * 최신 게시물 10개의 random data 가져오기
    * 다음 페이지 게시물 20개의 random data 가져오기 
* Autolayout

전체 요구사항
* 마감일 8/4
* Github PR 을 만들어서 commit, push (수시로 code review)
* MVC Pattern
* 게시물 목록
    * 데이터 변경에 반응하여 View 갱신
    * 내용, 작성 시간, 댓글 수 표시
    * (optional) Pull to refresh
        * indicator 표시
    * (optional) Infinite scroll
        * TableView/CollectionView 하단까지 scroll 하면 시작
        * indicator 표시
* 게시물 작성
    * 작성 후 목록으로 이동
    * (optional) 5자 이상 작성하면 등록 가능
* 게시물 상세
    * 상단에 게시물 내용 표시
    * (optional) 게시물 삭제
        * indicator 표시
        * 삭제 후 목록으로 이동
    * (optional) 하단에 댓글 작성뷰로 댓글 작성 (키보드가 올라오면 작성뷰도 올라 와야 함)
    * (optional) 댓글 작성 시간, 내용 표시
    * (optional) 댓글 삭제
        * indicator 표시
* DataStore (이름은 스스로 정함)
    * singleton
    * 모든 데이터를 관리함, 가상의 데이터 베이스
    * 게시물 생성, 삭제
    * 최신 게시물 10개의 random data 가져오기
    * 다음 페이지 게시물 20개의 random data 가져오기 
    * (optional) 모든 처리는 1초 후 완료
    * (optional) 모든 처리의 50%는 실패
* Autolayout
    * (optional) Landscape, Portrait 둘다 이용 가능 해야 함
* (optional) Indicator
    * 유저의 동작을 막는 indicator를 사용하지 않음
    * Activity indicator 도 함께 동작
* (optional) Opensource
    * Carthage 이용
    * (optional) SnapKit - AutoLayout은 개념이 중요하므로 쉽게 작성하도록 함
    * 더 원하는게 있다면 얘기해주세요.
* (optional) App Icon
* (optional) Launch screen
* (optional) Fabric - Answers, Crashlytics 적용
* (optional) Admob banner 적용
* (optional) facebook login 적용
    * (optional) 작성자로 페이스북 유저명을 표시
    * (optional) 작성자의 페이스북 사진 표시
    * (optional) 유저 사진 터치 후 페이스북 이동
