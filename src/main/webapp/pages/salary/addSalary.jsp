<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <div id="responseDiv"></div>
    <h2>添加工资</h2>
    <form method="post" id="addSalaryForm">
        部门名称:<input name="salary.s_salary"/><br/>
        <input id="addSalaryBtn" type="button" value="添加工资"/>
    </form>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</body>
</html>
<script>
    $("#addSalaryBtn").click(function () {
        $("#responseDiv").html("").empty();
        var param = $("#addSalaryForm").serialize();
        $.post("salaryAction_addSalary",param,function (data) {
            var font = null;
            if(data.msg==1){
                font = "<h4 style='color: green'>添加成功</h4>"
            }else if(data.msg==0){
                font ="<h4 style='color: red'>添加失败</h4>"
            }
            $("#responseDiv").append(font);
        },"json");
    });
</script>
