<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <div id="titleDiv"></div>
    <h3>工资列表</h3>
    <table border="1" id="tab">
        <tr>
            <td>编号</td>
            <td>工资</td>
            <td>状态</td>
        </tr>
    </table>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页"/>
    <div id="showDiv" style="width: 300px;height: 200px;background-color:aqua;border: 1px red solid;display: none; position: fixed;left: 660px;">
        <div id="showDivTitle"></div>
        <div style="position: absolute; top:50px;">
            <form method='post' id='updateSalaryForm'>
                <table>
                    <tr>
                        <td>基本工资:<input name="salary.s_salary"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" id="showDivUpdateBtn" onclick="doUpdateSalaryBtn()" value="执行修改"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" id="showDivCloseBtn" onclick="closeShowDiv()" value="关闭窗口"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

</body>
</html>
<script>
    $(function () {
        loadData();
    })
    //加载工资列表
    function loadData() {

        $("#tab tr:not(:first)").remove();
        $.get("salaryAction_findSalaryList","",function (data) {
            $.each(data.salaryList,function (i,v) {
                var tr = "<tr>";
                tr+="<td>"+i+"</td>";
                tr+="<td>"+v.s_salary+"</td>";
                tr+="<td> " +
                    "<input type='button' value='修改' onclick='toUpdateSalary("+v.s_no+")'><input type='button' value='删除' onclick='doDelSalary("+v.s_no+")'/> " +
                    "</td>";
                tr+="</tr>";
                $("#tab").append(tr)
            })
        },"json");
    }

    function doUpdateSalaryBtn() {
        $("#showDivTitle").html("").empty();
        var param = $("#updateSalaryForm").serialize();
        $.post("salaryAction_doUpdateSalary",param,function (data) {
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

   function toUpdateSalary(sno) {
       $("#showDivTitle").html("").empty();
       if($("#showDiv").css("display")=="none"){
           $("#showDiv").show();
           $.get("salaryAction_toUpdateSalary?salary.s_no="+sno,"",function (data) {
               var salary = data.salary;
               $("#showDiv input[name='salary.s_salary']").val(salary.s_salary);
               var input="<input name='salary.s_no' type='hidden' value='"+salary.s_no+"'/>";
               $("#updateSalaryForm").append(input);
           },"json")
       }else{
           closeShowDiv();
       }
   }
   
   function doDelSalary(sno) {
       $("#titleDiv").html("").empty();
       if (confirm("确定要删除吗？")) {
           $.post("salaryAction_delSalary?salary.s_no=" + sno, "", function (data) {
               var font = null;
               if (data.msg == 1) {
                   font = "<h3>删除成功</h3>";
               } else if (data.msg == 0) {
                   font = "<h3>删除失败</h3>";
               }
               $("#titleDiv").append(font);
               loadData();
           }, "json")
       }
   }

    //关闭修改框的js
    function closeShowDiv() {
        $("#showDiv").hide();
        $("#showDiv :not(input[id='showDivUpdateBtn'],input[id='showDivCloseBtn'])").val("");
        $("#showDiv input[name='salary.s_no']").remove();
    }
</script>

