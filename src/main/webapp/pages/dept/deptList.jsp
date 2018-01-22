<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <div id="titleDiv"></div>
    <h3>部门列表</h3>
    <table border="1" id="tab">
        <tr>
        <td>编号</td>
        <td>部门名称</td>
        <td>状态</td>
        </tr>
    </table>

    <div id="showDiv" style="width: 300px;height: 200px;background-color:aqua;border: 1px red solid;display: none; position: fixed;left: 660px;">
        <div id="showDivTitle"></div>
        <div style="position: absolute; top:50px;">
            <form method='post' id='updateDeptDiv'>
                <table>
                    <tr>
                        <td>部门名称:<input name="dept.d_name"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" id="showDivUpdateBtn" onclick="doUpdateDeptBtn()" value="执行修改"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" id="showDivCloseBtn" onclick="closeShowDiv()" value="关闭窗口"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</body>
</html>
<script>
    $(function () {
        loadData();
    })

    //加载部门列表
    function loadData() {
        $("#tab tr:not(:first)").remove();
        $.get("deptAction_findDeptList","",function (data) {
            $.each(data.deptList,function (i,v) {
                var tr = "<tr>";
                    tr+="<td>"+i+"</td>";
                    tr+="<td>"+v.d_name+"</td>";
                    tr+="<td> " +
                        "<input type='button' value='修改' onclick='toUpdateDept("+v.d_no+")'><input type='button' value='删除' onclick='dodelDept("+v.d_no+")'/> " +
                        "</td>";
                    tr+="</tr>";
                $("#tab").append(tr)
            })
        },"json");
    }

    //查询个对象的信息导入到修改div的js
    function toUpdateDept(dno) {
        $("#showDivTitle").html("").empty();
        if($("#showDiv").css("display")=="none"){
           $("#showDiv").show();
           $.get("deptAction_toUpdateDept?dept.d_no="+dno,"",function (data) {
                var dept = data.dept;
               $("#showDiv input[name='dept.d_name']").val(dept.d_name);
               var input="<input name='dept.d_no' type='hidden' value='"+dept.d_no+"'/>";
               $("#updateDeptDiv").append(input);
           },"json")
        }else{
            closeShowDiv();
        }
    }

    function dodelDept(dno) {
        $("#titleDiv").html("").empty();
        if (confirm("确定要删除吗？")) {
            $.post("deptAction_delDept?dept.d_no=" + dno,"", function (data) {
                var font = null;
                if (data.msg == 1) {
                    font = "<h3>删除成功</h3>";
                } else if (data.msg == 0) {
                    font = "<h3>删除失败</h3>";
                }
                $("#titleDiv").append(font);
                loadData();
            },"json");
        }
    }

    //执行修改用户
    function doUpdateDeptBtn() {
        $("#showDivTitle").html("").empty();
        var param = $("#updateDeptDiv").serialize();
        $.post("deptAction_doUpdateDept",param,function (data) {
            var font = null;
            if(data.msg==1){
                font ="<h4>执行修改成功</h4>";
            }else if(data.msg==0){
                font ="<h4>执行修改失败</h4>";
            }
            $("#showDivTitle").append(font);
            loadData();
        },"json");
    }

    //关闭修改框的js
    function closeShowDiv() {
        $("#showDiv").hide();
        $("#showDiv :not(input[id='showDivUpdateBtn'],input[id='showDivCloseBtn'])").val("");
        $("#showDiv input[name='dept.d_no']").remove();
    }
</script>
