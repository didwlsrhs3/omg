<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
  <thead>
    <tr>
      <th>글번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
      <th>추천수</th>
      <th>지역카테고리</th>
    </tr>
  </thead>
  <tbody id="list">
    <!-- 초기에는 비워두고 JS로 채움 -->
  </tbody>
</table>

<select id="category">
  <option value="1">서울</option>
  <option value="2">부산</option>
  <!-- 생략 -->
</select>
</body>
</html>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const categorySelect = document.getElementById("category");
  const listEl = document.getElementById("list");

  if (!categorySelect || !listEl) {
    console.error("필수 요소를 찾을 수 없습니다.");
    return;
  }

  categorySelect.addEventListener("change", function () {
    const category_id = categorySelect.value;
    const url = "/board/board/localboard/" + category_id;

    fetch(url)
      .then(res => res.json())
      .then(data => {
        if (!Array.isArray(data)) {
          listEl.innerHTML = `<tr><td colspan="7">데이터가 없습니다.</td></tr>`;
          return;
        }

        const rows = data.map(list => {
          const date = new Date(list.regdate).toLocaleDateString();
          return `
            <tr>
              <td>${list.bno}</td>
              <td><a href="localreadPage?bno=${list.bno}">${list.title}</a></td>
              <td>${list.nickname}</td>
              <td>${list.date}</td>
              <td>${list.viewcnt}</td>
              <td>${list.agree}</td>
              <td>${list.category_id}</td>
            </tr>
          `;
        }).join('');

        listEl.innerHTML = rows;
      })
      .catch(err => {
        console.error("불러오기 실패:", err);
        listEl.innerHTML = `<tr><td colspan="7">게시글을 불러올 수 없습니다.</td></tr>`;
      });
  });
});
</script>