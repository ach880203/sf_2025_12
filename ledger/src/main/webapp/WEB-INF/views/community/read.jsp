<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="gb-page">

	<div class="row justify-content-center">
		<div class="col-lg-12">

			<div class="card gb-card shadow mb-4">
				<div class="gb-card-header">
					<h6 class="gb-card-title">Community Read 📖</h6>

					<c:url var="readUrl" value="/community/list">
						<c:param name="page" value="${page}" />
						<c:param name="size" value="${size}" />
						<c:param name="types" value="${types}" />
						<c:param name="keyword" value="${keyword}" />
					</c:url>

					<a href='${readUrl}' class="gb-btn gb-btn-ghost">목록</a>
				</div>

				<div class="gb-card-body gb-form">

					<div class="mb-3 input-group input-group-lg">
						<span class="input-group-text">글번호</span> <input type="text"
							class="form-control" value="<c:out value='${community.bno}'/>"
							readonly>
					</div>

					<div class="mb-3 input-group input-group-lg">
						<span class="input-group-text">제목</span> <input type="text"
							name="title" class="form-control"
							value="<c:out value='${community.title}'/>" readonly>
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold" style="color: #3a2a00;">내용</label>
						<textarea class="form-control" name="content" rows="6" readonly><c:out
								value="${community.content}" /></textarea>
					</div>

					<div class="mb-3 input-group input-group-lg">
						<span class="input-group-text">글쓴이</span> <input type="text"
							name="writer" class="form-control"
							value="<c:out value='${community.writer}'/>" readonly>
					</div>

					<div class="mb-3 input-group input-group-lg">
						<span class="input-group-text">작성일</span> <input type="text"
							name="regDate" class="form-control"
							value="<c:out value='${community.createdDate}'/>" readonly>
					</div>

					<div class="d-flex justify-content-end gap-2">
						<a href='${readUrl}' class="gb-btn gb-btn-ghost">목록</a>

						<sec:authentication property="principal" var="secInfo" />
						<sec:authentication property="authorities" var="roles" />

						<c:if
							test="${!community.delFlag && (secInfo.uid == community.writer || fn:contains(roles, 'ROLE_ADMIN'))}">
							<a href="/community/modify/${community.bno}"
								class="gb-btn gb-btn-primary">✨수정</a>
						</c:if>
					</div>

				</div>
			</div>

		</div>
	</div>

	<!-- 댓글 작성 -->
	<div class="col-lg-12">
		<div class="card gb-card shadow mb-4">
			<div class="gb-card-header">
				<h6 class="gb-card-title">댓글💬</h6>
			</div>

			<div class="gb-card-body">
				<form id="replyForm" class="gb-form">
					<input type="hidden" name="bno" value="${community.bno}" />

					<div class="mb-3 input-group input-group-lg">
						<span class="input-group-text">작성자</span> <input type="text"
							name="replyer" class="form-control" required
							value='<sec:authentication property="principal.uid"/>' />
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold" style="color: #3a2a00;">내용</label>
						<textarea name="replyText" class="form-control" rows="3" required></textarea>
					</div>

					<div class="text-end">
						<button type="submit" class="gb-btn gb-btn-primary addReplyBtn">✨댓글 작성</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 댓글 목록 -->
	<div class="col-lg-12">
		<div class="card gb-card shadow mb-4">
			<div class="gb-card-body">
				<ul class="list-group replyList">
					<li class="list-group-item">
						<div class="d-flex justify-content-between">
							<div>
								<strong>번호</strong> - 댓글 내용
							</div>
							<div class="text-muted small">작성일</div>
						</div>
						<div class="mt-1 text-secondary small">작성자</div>
					</li>
				</ul>

				<div aria-label="댓글 페이지 네비게이션" class="mt-4">
					<ul class="pagination justify-content-center"></ul>
				</div>
			</div>
		</div>
	</div>

</div>

<!-- 댓글 모달 -->
<div class="modal fade" id="replyModal" tabindex="-1"
	aria-labelledby="replyModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content"
			style="border-radius: 18px; overflow: hidden;">
			<div class="modal-header">
				<h5 class="modal-title" id="replyModalLabel">댓글 수정 / 삭제</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>

			<div class="modal-body">
				<form id="replyModForm">
					<input type="hidden" name="rno" value="33">
					<div class="mb-3">
						<label for="replyText" class="form-label">댓글 내용</label> <input
							type="text" name="replyText" id="replyText" class="form-control"
							value="Reply Text" />
					</div>
				</form>
			</div>

			<div class="modal-footer">
				<sec:authentication property="principal" var="secInfo" />
				<sec:authentication property="authorities" var="roles" />
				<c:if
					test="${!community.delFlag && (secInfo.uid == community.writer || fn:contains(roles, 'ROLE_ADMIN'))}">
					<button type="button" class="gb-btn gb-btn-primary btnReplyMod">수정</button>
					<button type="button" class="gb-btn gb-btn-danger btnReplyDel">삭제</button>
				</c:if>
				<button type="button" class="gb-btn gb-btn-ghost"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 여기 아래 JS는 네 원본 그대로 유지 -->
<script type="text/javascript">
  const replyForm = document.querySelector("#replyForm");

  document.querySelector(".addReplyBtn").addEventListener("click", e=>{
    e.preventDefault();
    e.stopPropagation();

    const formData = new FormData(replyForm);
    const data = Object.fromEntries(formData.entries());
    const jsonData = JSON.stringify(data);

    axios.post("/replies", jsonData, {
      headers: { 'Content-Type': 'application/json' }
    })
    .then(res => {
      replyForm.reset();
      getReplies(1, true);
    })
    .catch(err => {
      console.error("여전히 에러가 난다면 서버 코드를 확인하세요!", err.response);
    });

  }, false);

  let currentPage = 1;
  let currentSize = 10;
  const bno = ${community.bno};

  function getReplies(pageNum, goLast){
    axios.get(`/replies/\${bno}/list`, {
      params: { page: pageNum || currentPage, size: currentSize }
    }).then(res => {
      const data = res.data;
      const {totalCount, page, size}  = data;

      if( goLast && (totalCount > (page*size)) ){
        const lastPage = Math.ceil(totalCount/size);
        getReplies(lastPage);
      }else{
        currentPage = page;
        currentSize = size;
        printReplies(data)
      }
    });
  }

  const replyList = document.querySelector(".replyList");

  function printReplies(data){
    const {replyDTOList, page,size, prev, next, start, end, pageNums}  = data;
    let liStr = "";

    for(replyDTO of replyDTOList){
      liStr +=  `<li class="list-group-item" data-rno="\${replyDTO.rno}">
                  <div class="d-flex justify-content-between">
                    <div><strong>\${replyDTO.rno}</strong> - \${replyDTO.replyText}</div>
                    <div class="text-muted small">\${replyDTO.replyDate}</div>
                  </div>
                  <div class="mt-1 text-secondary small">\${replyDTO.replyer}</div>
                </li>`
    }
    replyList.innerHTML = liStr

    let paginStr = "";
    if(prev){
      paginStr += `<li class="page-item"><a class="page-link" href="\${start-1}" tabindex="-1">이전</a></li>`;
    };

    for(let i of pageNums){
      paginStr += `<li class="page-item \${i===page ? 'active' : ''}">
                    <a class="page-link" href="\${i}">\${i}</a>
                  </li>`;
    };

    if(next){
      paginStr += `<li class="page-item"><a class="page-link" href="\${end + 1}">다음</a></li>`
    }

    document.querySelector(".pagination").innerHTML = paginStr;
  }

  document.querySelector(".pagination").addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();
    const target = e.target;
    const href = target.getAttribute("href");
    if(!href){ return ; }
    getReplies(href);
  }, false);

  getReplies(1 , true);

  const replyModal = new bootstrap.Modal(document.querySelector("#replyModal"));
  const replyModForm = document.querySelector("#replyModForm");

  replyList.addEventListener("click", e => {
    const targetLi = e.target.closest("li");
    const rno = targetLi?.getAttribute("data-rno");
    if(!rno){ return }

    axios.get(`/replies/\${rno}`).then(res => {
      const targetReply = res.data;
      if(targetReply.delflag == false){
        replyModForm.querySelector("input[name = 'rno']").value = targetReply.rno;
        replyModForm.querySelector("input[name = 'replyText']").value = targetReply.replyText
        replyModal.show();
      }else{
        alert("삭제된 댓글은 조회할 수 없습니다.");
      }
    });
  }, false);

  document.querySelector(".btnReplyDel")?.addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();

    const formData = new FormData(replyModForm);
    const rno = formData.get("rno");

    axios.delete(`/replies/\${rno}`).then( res => {
      alert("삭제 성공했습니다.");
      replyModal.hide();
      getReplies(currentPage);
    });
  }, false);

  document.querySelector(".btnReplyMod")?.addEventListener("click", e=>{
    e.preventDefault();
    e.stopPropagation();

    const formData = new FormData(replyModForm);
    const rno = formData.get("rno");

    axios.put(`/replies/\${rno}`, formData ).then(res => {
      alert("수정이 성공했습니다.");
      replyModal.hide();
      getReplies(currentPage);
    })
  }, false);
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
