<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <h2>添加奖罚记录</h2>
    <form id="addSalaryInfoFrm">
        <table border="1">
        <tr>
            <td>员工名称:</td>
            <td>
                <select id="salaryEmpSelect" name="salaryInfo.emp.e_no">
                    <option value="">选择员工名称</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>标题名:</td><td><input name="salaryInfo.si_titel"/></td>
        </tr>
        <tr>
            <td>详情内容:</td><td><textarea rows="5" cols="60" name="salaryInfo.si_content"></textarea></td>
        </tr>
        <tr>
            <td>申请时间:</td><td><input type="date" name="salaryInfo.si_time"/></td>
        </tr>
        <tr>
            <td>考勤类型:</td>
            <td>
                <input type="radio" name="salaryInfo.si_casetype" value="其他" id="caseTypeFiveRadio" checked/><label for="caseTypeFiveRadio">其他</label>
                <input type="radio" name="salaryInfo.si_casetype" value="奖励" id="caseTypeFourRadio"/><label for="caseTypeFourRadio">奖励</label>
                <input type="radio" name="salaryInfo.si_casetype" value="迟到" id="caseTypeOneRadio"/><label for="caseTypeOneRadio">迟到</label>
                <input type="radio" name="salaryInfo.si_casetype" value="事假" id="caseTypeTwoRadio"/><label for="caseTypeTwoRadio">事假</label>
                <input type="radio" name="salaryInfo.si_casetype" value="病假" id="caseTypeThreeRadio"/><label for="caseTypeThreeRadio">病假</label>
            </td>
        </tr>
        <tr>
            <td>奖罚工资:</td>
            <td>
                <input type="radio" name="judgeSalaryRadio" value="1" id="fixedlySalaryRadio" checked/><label for="fixedlySalaryRadio">无加减</label>
                <input type="radio" name="judgeSalaryRadio" value="2" id="addSalaryRadio"/><label for="addSalaryRadio"> 加钱</label>
                <input type="radio" name="judgeSalaryRadio" value="3" id="subtractSalaryRadio"/><label for="subtractSalaryRadio">减钱</label><br/>
                <input name="salaryInfo.si_variate" disabled="disabled" placeholder="无加减，禁止输入" />
            </td>
        </tr>
        <tr>
            <td><input type="reset" value="重置"/><input type="button" id="doAddEmpSalaryInfoBtn"  onclick="doAddEmpSalaryInfo()" value="添加考勤记录"/></td>
        </tr>
    </table>
    </form>
</body>
</html>
<script>
    //判断是否要加减工资，如果需要开启 输入金额框
    $("#addSalaryRadio").click(function () {
        $("#addSalaryInfoFrm input[name='salaryInfo.si_variate']").attr("disabled",false).attr("placeholder","请输入要（加）的工资");
    });
    $("#subtractSalaryRadio").click(function () {
        $("#addSalaryInfoFrm input[name='salaryInfo.si_variate']").attr("disabled",false).attr("placeholder","请输入要（减）的工资");
    });
    $("#fixedlySalaryRadio").click(function () {
        $("#addSalaryInfoFrm input[name='salaryInfo.si_variate']").attr("disabled",true).attr("placeholder","无加减，禁止输入");
    });
    $(function () {
        salaryEmpSelect();
    })
    //加载工资到select
    function salaryEmpSelect() {
        $.get("empAction_findEmpList","",function (data) {
            $.each(data.empList,function (i,v) {
                var option = "<option value='"+v[0].e_no+"'>"+v[0].e_name+"</option>";
                $("#salaryEmpSelect").append(option);
            })
        },"json");
    }

    function doAddEmpSalaryInfo() {
        var param = $("#addSalaryInfoFrm").serialize();
        $.post("salaryInfoAction_addSalaryInfo",param,function (data) {
            alert(data.msg)
        },"json");

    }
</script>
