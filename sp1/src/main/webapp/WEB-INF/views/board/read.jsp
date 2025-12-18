<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="row justify-content-center">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 fw-bold text-primary">Board Read</h6>
			</div>
			<div class="card-body">

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Bno</span> <input type="text"
						class="form-control" value="<c:out value='${board.bno}'/>"
						readonly>
				</div>

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Title</span> <input type="text"
						name="title" class="form-control"
						value="<c:out value='${board.title}'/>" readonly>
				</div>

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Content</span>
					<textarea class="form-control" name="content" rows="3" readonly><c:out
							value="${board.content}" /></textarea>
				</div>

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Writer</span> <input type="text"
						name="writer" class="form-control"
						value="<c:out value='${board.writer}'/>" readonly>
				</div>

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">RegDate</span> <input type="text"
						name="regDate" class="form-control"
						value="<c:out value='${board.createdDate}'/>" readonly>
				</div>

				<div class="float-end">
					<c:url var="readUrl" value="/board/list">
						<c:param name="page" value="${page}" />
						<c:param name="size" value="${size}" />
						<c:param name="types" value="${types}" />
						<c:param name="keyword" value="${keyword}" />
					</c:url>
					<a href='${readUrl}'>
						<button type="button" class="btn btn-info btnList">LIST</button>
					</a>
					<c:if test="${!board.delFlag}">
						<a href='/board/modify/${board.bno}'>
							<button type="button" class="btn btn-warning btnModify">MODIFY</button>
						</a>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</div>


<div class="col-lg-12">
	<div class="card shadow mb-4">
		<div class='m-4'>
			<!--댓글 작성 폼 -->
			<form id="replyForm" class="mt-4">
				<!-- 게시글 번호 hidden 처리 -->
				<input type="hidden" name="bno" value="${board.bno}" />

				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Replyer</span> <input type="text"
						name="replyer" class="form-control" required />
				</div>

				<div class="mb-3 input-group">
					<span class="input-group-text">Reply Text</span>
					<textarea name="replyText" class="form-control" rows="3" required></textarea>
				</div>

				<div class="text-end">
					<button type="submit" class="btn btn-primary addReplyBtn">Submit
						Reply</button>
				</div>
			</form>
			<!-- 댓글 작성 폼 끝 -->
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">
	
//HTML에서 id가 "replyForm"인 폼(form) 요소를 찾아 변수에 저장합니다.
const replyForm = document.querySelector("#replyForm");
   
// 클래스가 "addReplyBtn"인 버튼을 찾아 클릭 이벤트 리스너를 등록합니다.
document.querySelector(".addReplyBtn").addEventListener("click", e=>{
    
    // 폼 제출 시 페이지가 새로고침되는 브라우저의 기본 동작을 막습니다.
    e.preventDefault();
    
    // 클릭 이벤트가 상위 요소로 퍼져나가는 것(버블링)을 방지합니다.
    e.stopPropagation();      
    
    // 폼(replyForm) 안에 입력된 모든 데이터를 FormData 객체로 생성합니다.
    const formData = new FormData(replyForm);
    
    // FormData의 데이터를 서버로 보내기 좋게 일반 객체(Key: Value 형태)로 변환합니다.
    // ※ 주의: 소문자 object가 아니라 대문자 Object로 써야 에러가 나지 않습니다.
    const data = Object.fromEntries(formData.entries());
    
    const jsonData = json.stringify(Data);
    	console.log(Data);
    	console.log(json.Data);
    
    // axios 라이브러리를 사용해 "/replies" 주소로 POST 방식의 데이터 전송을 요청합니다.
    axios.post("/replies", data, {
          headers: {
              // 보내는 데이터의 형식이 JSON임을 서버에 알려줍니다.
              'Content-Type': 'application/json' 
          }
     })
    // 서버 전송에 성공했을 때 실행되는 구간입니다.
    .then(res => {
         console.log("------성공 응답-------------");
         console.log(res.data); // 서버에서 보내준 결과 데이터를 콘솔에 출력합니다.
         
         // 전송이 성공했으므로 폼에 입력되어 있던 내용을 모두 비웁니다.
         replyForm.reset();
     })
    // 서버 전송 중 에러가 발생했을 때 실행되는 구간입니다.
    .catch(err => {
         // 에러 메시지와 함께 서버의 응답 내용을 콘솔에 출력합니다.
         console.error("여전히 에러가 난다면 서버 코드를 확인하세요!", err.response);
    });
    
}, false); // 이벤트 캡처링 단계를 사용하지 않겠다는 의미의 기본값입니다.
	
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>