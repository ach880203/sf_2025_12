<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="gb-page">

	<div class="row justify-content-center">
		<div class="col-lg-12">

			<div class="card gb-card shadow mb-4">
				<div class="gb-card-header">
					<h6 class="gb-card-title">돈 되는 나눔 방 💬</h6>
					<a href="/community/register" class="gb-btn gb-btn-primary"> ✍️
						등록 </a>
				</div>

				<div class="gb-card-body">

					<table class="gb-table" id="dataTable">
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>글쓴이</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<c:forEach var="community" items="${dto.communityDTOList}">
								<tr data-bno=${community.bno}>
									<td><c:out value="${community.bno}" /></td>
									<td><c:url var="readUrl"
											value="/community/read/${community.bno}">
											<c:param name="page" value="${dto.page}" />
											<c:param name="size" value="${dto.size}" />
											<c:param name="types" value="${dto.types}" />
											<c:param name="keyword" value="${dto.keyword}" />
										</c:url> <a href="${readUrl}"> <c:out value="${community.title}" />
											<b style="color: #2a6cff">[ <c:out
													value="${community.replyCnt}" /> ]
										</b>
									</a></td>
									<td><c:out value="${community.writer}" /></td>
									<td><c:out value="${community.createdDate}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<!-- 검색 조건 -->
					<div class="gb-toolbar">
						<div style="width: 260px;">
							<select name="typeSelect" class="form-select">
								<option value="">--</option>
								<option value="T" ${dto.types == 'T' ? 'selected' : '' }>제목</option>
								<option value="C" ${dto.types == 'C' ? 'selected' : '' }>내용</option>
								<option value="W" ${dto.types == 'W' ? 'selected' : '' }>작성자</option>
								<option value="TC" ${dto.types == 'TC' ? 'selected' : '' }>제목
									OR 내용</option>
								<option value="TW" ${dto.types == 'TW' ? 'selected' : '' }>제목
									OR 작성자</option>
								<option value="TCW" ${dto.types == 'TCW' ? 'selected' : '' }>제목
									OR 내용 OR 작성자</option>
							</select>
						</div>

						<input type="text" class="form-control" name="keywordInput"
							value="<c:out value='${dto.keyword}'/>" />

						<button class="btn searchBtn">찾기</button>
					</div>
					<!-- end 검색 조건 -->

					<!-- 페이징 처리 -->
					<div class="d-flex justify-content-center">
						<ul class="pagination">
							<c:if test="${dto.prev}">
								<li class="page-item"><a class="page-link"
									href="${dto.start - 1 }" tabindex="-1">Prev</a></li>
							</c:if>

							<c:forEach var="num" items="${dto.pageNums}">
								<li class="page-item ${dto.page == num ? 'active' : ''}"><a
									class="page-link" href="${num}">${num}</a></li>
							</c:forEach>

							<c:if test="${dto.next}">
								<li class="page-item"><a class="page-link"
									href="${dto.end + 1}">Next</a></li>
							</c:if>
						</ul>
					</div>
					<!-- end 페이징 처리 -->

				</div>
			</div>
		</div>
	</div>

	<!-- 등록 모달 -->
	<div class="modal" tabindex="-1" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content" style="border-radius: 18px;">
				<div class="modal-header">
					<h5 class="modal-title">✨ 등록 완료</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						<span id="modalResult"></span>번 글이 등록되었습니다.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="gb-btn gb-btn-ghost"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript" defer="defer">
  const result = '${result}'
  const myModal = new bootstrap.Modal(document.getElementById('myModal'));

  if(result){
    document.getElementById('modalResult').innerText = result;
    myModal.show();
  }

  // 페이징 이벤트 처리
  const pagingDiv = document.querySelector(".pagination");
  pagingDiv.addEventListener("click", (e) => {
    e.preventDefault();
    e.stopPropagation();

    const target = e.target;
    const targetPage =  target.getAttribute("href");
    if(!targetPage){ return; }

    const size = ${dto.size} || 10 ;

    const params = new URLSearchParams({
      page: targetPage,
      size: size
    });

    const types = '${dto.types}';
    const keyword = '${dto.keyword}';

    if(types && keyword){
      params.set("types", types);
      params.set("keyword", keyword);
    }

    self.location = `/community/list?\${params.toString()}` ;
  }, false);

  //검색 조건
  document.querySelector(".searchBtn").addEventListener("click", (e) => {
    const keyword = document.querySelector("input[name='keywordInput']").value;
    const types = document.querySelector("select[name='typeSelect']").value;

    const params = new URLSearchParams({ types, keyword });
    self.location = `/community/list?\${params.toString()}`;
  });
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
