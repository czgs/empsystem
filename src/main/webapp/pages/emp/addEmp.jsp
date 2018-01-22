<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
<div>
    <div id="titelDiv"></div>
    <form method="post" id="addEmpForm" >
        <table>
            <tr>
                <td>员工姓名:</td><td><input placeholder="请输入姓名" name="emp.e_name"></td>
            </tr>
            <tr>
                <td>员工年龄:</td><td><input name="emp.e_age"/></td>
            </tr>
            <tr>
                <td>员工性别:</td>
                <td>
                    <input type="radio" name="emp.e_sex" id="empSexradioOne" value="男"/><label for="empSexradioOne">男</label>
                    <input type="radio" name="emp.e_sex" id="empSexradioTwo" value="女"/><label for="empSexradioTwo">女</label>
                </td>
            </tr>
            <tr>
                <td>员工头像:</td>
                <td>
                    <input type="file" name="empImage">
                </td>
            </tr>
           <tr>
                <td>所属部门:</td>
                <td>
                    <select id="deptSelect" name="emp.dept.d_no">
                        <option value="">选择部门</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>基本工资:</td>
                <td>
                    <select id="salarySelect" name="emp.salary.s_no">
                        <option value="">选择工资</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>账号</td>
                <td>
                    <input name="user.u_name"/><div id="userNameDiv"></div>
                </td>
            </tr>
            <tr>
                <td>密码</td>
                <td>
                    <input type="password" name="user.u_pwd"/>
                </td>
            </tr>
            <tr>
                <td>职位</td>
                <td>
                    <input type="radio" name="user.u_status" value="0" id="userStatusRadioOne" checked/><label for="userStatusRadioOne">普通员工</label>
                    <input type="radio" name="user.u_status" value="1" id="userStatusRadioTwo" /><label for="userStatusRadioTwo">主管</label>

                </td>
            </tr>
            <tr>
                <td rowspan="2"><input type="reset" value="重置"/><input type="button" id="addEmpBtn" value="添加员工" /></td>
            </tr>

        </table>
    </form>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</div>
</body>
</html>
<script>
    $(function () {
        deptSelect();
        salarySelect();
    })

    //加载部门到select
    function deptSelect() {
        $.get("deptAction_findDeptList","",function (data) {
            $.each(data.deptList,function (i,v) {
                var option = "<option value='"+v.d_no+"'>"+v.d_name+"</option>";
                $("#deptSelect").append(option);
            })
        },"json");
    }

    //加载工资到select
    function salarySelect() {
        $.get("salaryAction_findSalaryList","",function (data) {
            $.each(data.salaryList,function (i,v) {
                var option = "<option value='"+v.s_no+"'>"+v.s_salary+"元</option>";
                $("#salarySelect").append(option);
            })
        },"json");
    }

    //填写完账号后，查询判断有没有这个用户存在
    $("input[name='user.u_name']").blur(function () {
        $("#userNameDiv").html("").empty();
        var uname = $("input[name='user.u_name']").val();
        if(uname!=null&&uname.length>0){
            $.get("userAction_findUserName?user.u_name="+uname,"",function (data) {
                if(data.msg==1){
                    var font="<p style='color: red'>用户已经存在</p>";
                    $("#userNameDiv").append(font);
                }else {
                    var font="<p style='color: green'>用户可以使用</p>";
                    $("#userNameDiv").append(font);
                }
            })
        }
    });

   //执行添加员工
    $("#addEmpBtn").click(function () {
        $("#titelDiv").html("").empty();
       //使用FormData方法，传入表单，获取表单信息
        var form = new FormData(document.getElementById("addEmpForm"));
        //使用异步
        $.ajax({
            url:"empAction_addEmp",
            type:"post",
            //这里的data相当于post方法的param
            data:form,
            //这两个极为重要，必须要设置为false
            processData:false,
            contentType:false,
            success:function (data) {
                if(data.msg==1){
                    var font ="<h3>添加员工成功</h3>";
                    $("#titelDiv").append(font);
                }else{
                    var font ="<h3>添加员工失败</h3>";
                    $("#titelDiv").append(font);
                }
            }
    });
       /* var param = $("#addEmpForm").serialize();
        $.post("empAction_addEmp",param,function (data) {

        });*/
    });
</script>
