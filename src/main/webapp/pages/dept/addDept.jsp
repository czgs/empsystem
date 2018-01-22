<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <div id="responseDiv"></div>
    <h2>添加部门</h2>
    <form method="post" id="addDeptForm">
        部门名称:<input name="dept.d_name"/><br/>
        <input id="addDeptBtn" type="button" value="添加部门"/>
    </form>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</body>
</html>
<script>
    $("#addDeptBtn").click(function () {
        var param = $("#addDeptForm").serialize();
        $("#responseDiv").empty();
        $.post("deptAction_addDept",param,function (data) {
            var font ="";
            if(data.msg==1){
                font+="<h3>添加部门成功</h3>";
            }else if (data.msg==0){
                font+="<h3 style='color:red;'>添加失败,部门名称重复</h3>"
            }
            $("#responseDiv").append(font);
        },"json");
    });
</script>
