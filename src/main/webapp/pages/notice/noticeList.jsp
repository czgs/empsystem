<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<style>

    /*#showUpdateNoticeDiv{

        border: 1px solid rgb(48,168,158);
        height: 50%;
        width:50%;background:#FFF;
        position:absolute;
        margin: 0 auto;
        display:none; z-index:1000;
        border:rgb(65,100,127) 1px dashed;
        border-radius:7px;
        box-shadow:5px 5px 30px #000;
        top:20%;
        left:25%;
    }*/
</style>
<body>
<div id="noticeMainDiv" style="margin: 0 auto;">
    <div id="titleDiv"></div>
    <div style="margin: 0px auto;width: 80%">
    <table border="1" id="tab" class="layui-table">
     <tr>
        <td>编号</td><td>标题</td>
        <td>时间</td><td>发布人</td>
        <td>发布人账号</td><td>状态</td>
    </tr>
    </table>
    </div>
    <!--下面是 修改公告 的div  管理员的特权-->
    <%--<div style="" id="showUpdateNoticeDiv">
        <div style="height: 10%;width: 100%;background-color: rgb(0,159,149);border-top-left-radius:7px;border-top-right-radius:7px;">
            <h3 style="color: #FFFFFF;text-align:center;line-height: 210%;">修改公告信息</h3>
        </div>
        <br/>
        <form class="layui-form"  id="updateNoticeForm" action="" style="margin: 0 auto;width: 50%;">
            <input name="notice.n_no" type="hidden"/>
            <input name="notice.user.u_no" type="hidden"/>
            <div class="layui-form-item">
                <label class="layui-form-label">标&nbsp;题&nbsp;：</label>
                <div class="layui-input-inline">
                    <input type="text" name="notice.n_titel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">详细内容：</label>
                <div class="layui-input-block" style="width: 500px;">
                    <textarea name="notice.n_content" lay-verify="required" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">创建时间：</label>
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <input type="text" name="notice.n_date" lay-verify="required" placeholder="点击选择时间" class="layui-input" id="noticeInputDateId">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="button" class="layui-btn layui-btn-radius" id="doUpdateNoticeBtnId" onclick="doUpdateNoticeBtn()"  value="修改" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" id="closeUpdateNoticeBtnId" onclick="closeShowDiv()" value="关闭" />
                </div>
            </div>
        </form>
    </div>--%>
        <%--
            <input name="notice.user.u_no" type="hidden" value="${loginUser.u_no}">
            <div class="layui-form-item">
                <label class="layui-form-label">标&nbsp;题&nbsp;：</label>
                <div class="layui-input-inline">
                    <input type="text" name="notice.n_titel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">详细内容：</label>
                <div class="layui-input-block" style="width: 500px;">
                    <textarea name="notice.n_content" lay-verify="required" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">创建时间：</label>
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <input type="text" name="notice.n_date" lay-verify="required" placeholder="点击选择时间" class="layui-input" id="noticeInputDateId">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <div class="layui-btn" lay-submit lay-filter="formDemo">立即提交</div>
                    <button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>--%>

    <%--<!--查看具体公告的DIV  普通员工的特权-->
    <div style="display: none" id="showSelectNoticeDiv">
        <table>
            <tr>
                <td>标题:</td><td><input placeholder="请输入标题" name="notice.n_titel"></td>
            </tr>
            <tr>
                <td>详细内容:</td><td><textarea rows="5" cols="60" name="notice.n_content"></textarea></td>
            </tr>
            <tr>
                <td>创建时间:</td><td><input type="date" name="notice.n_date"/></td>
            </tr>
            <tr>
                <td rowspan="2">
                    <input type="button" id="closeSelectNoticeBtnId" onclick="closeShowSelectDiv()" value="关闭" />
                </td>
            </tr>
        </table>
    </div>--%>
</div>
</body>
</html>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    $(function () {
        loadData();
    })
    //加载公告列表的JS
    function loadData(num) {
        //判断是不是第一次页面加载，第一次页面加载 num是没有值得 所以需要三目运算，如果为空，则页数为1。
        num = num==null?1:num;
        $("#tab tr:not(:first)").remove();
        $.get("noticeAction_findNoticeList?bean.cpage="+num,"",function (data) {
            $.each(data.bean.result,function (i,v) {
                var tr="<tr>"
                    //=============================添加编号=========================================
                    tr+="<td>"+((data.bean.cpage-1)*data.bean.showNum+i+1)+"</td>";
                    //=============================添加标题=========================================
                    tr+="<td>"+v[0].n_titel+"</td>";
                    //=============================添加时间=========================================
                    tr+="<td>"+v[0].n_date.substring(0,10)+"</td>";
                    //=============================添加姓名（职位）=========================================
                    if(v[1]==null){ //判断v[1]是不是为空，如果为空，证明是老板用户，老版用户没有个人信息，Emp
                        tr+="<td>老板用户</td>";
                    }else{
                        //看看user表中status中的特权是多少,用三目运算判断
                        //整体完善以后,下面的==2 需要改为1   因为2是超级用户，员工表还没完善，只能暂时测试
                        v[0].user.u_status==1?tr+="<td>"+v[1].e_name+"(主管)</td>" : tr+="<td>"+v[1].e_name+"(普通员工)</td>";
                    }
                    //=============================添加用户账号=============================
                    tr+="<td>"+v[0].user.u_name+"</td>";
                    //=============================添加状态操作(根据不同用户特权权限，显示不同按钮操作)=============================
                    var loginStatus=${loginUser.u_status};
                    if(loginStatus==2||loginStatus==1){
                        tr+="<td>"
                        +" <input type='button' class='layui-btn layui-btn-sm layui-icon' value='&#xe615;' onclick='findNoticeBtn("+v[0].n_no+")'/>"
                        +" <input type='button' class='layui-btn layui-btn-normal layui-btn-sm layui-icon' value='&#xe642;' onclick='toUpdateNoticeBtn("+v[0].n_no+")'/> "
                        +" <input type='button' class='layui-btn layui-btn-danger layui-btn-sm layui-icon' value='&#xe640;'  onclick='doDelNoticeBtn("+v[0].n_no+")'/> "
                        +" </td>";
                    }else if(loginStatus==0){
                        tr+="<td><input type='button' value='查看' onclick='selectNoticeBtn("+v[0].n_no+")'/></td>";
                    }
                    tr+="</tr>";
                    $("#tab").append(tr);
            })
                    var bean = data.bean;
            //((data.bean.cpage-1)*data.bean.showNum+i+1)
            //判断用户data.bean.result，这个list里面为不为空,则加载跳转页按钮
            if(data.bean.result.length>0&&data.bean.result!=null){
                var upPage = data.bean.cpage-1==0?1:data.bean.cpage-1; //上一页
                var downPage = data.bean.cpage+1>data.bean.allPage?data.bean.allPage:data.bean.cpage+1;
                var tr2="<tr><td colspan='6'> "
                        + "<div style='margin:0 auto;width: 33%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                        + "<button class='layui-btn layui-btn-xs layui-btn-primary' onclick='doPage(1)'><i class='layui-icon'>&#xe603;</i></button>"
                        + "<button class='layui-btn layui-btn-xs layui-btn-primary' onclick='doPage("+upPage+")'><i class='layui-icon'>&#xe65a;</i></button>"
                        + "<button class='layui-btn layui-btn-xs layui-btn-primary' onclick='doPage("+downPage+")'><i class='layui-icon'>&#xe65b;</i></button>"
                        + "<button class='layui-btn layui-btn-xs layui-btn-primary' onclick='doPage("+data.bean.allPage+")'><i class='layui-icon'>&#xe602;</i></button> "
                        + "<p>总共查询" +data.bean.allNum+"条数据，当前第" +data.bean.cpage+"页，总共有"+data.bean.allPage+"页。</p>"
                        + "</div></td></tr>";
                $("#tab").append(tr2);
            }
        },"json");
    }

    //跳转到哪一页的JS方法  num是接收button传过来的值
    function doPage(num) {
        loadData(num);
    }


    //查看公告信息
    function findNoticeBtn(nno){
        $.get("noticeAction_toUpdateNotice?notice.n_no="+nno,"",function (data) {
            var notice = data.notice;
            if(notice.user.u_status==2){
                var status = '老板';
            }else if(notice.user.u_status==2){
                var status = '主管';
            }
            layer.open({
                type: 1,
                skin: 'layui-layer-molv',//样式类名
                title:'公告详细信息',
                anim: 2,
                closeBtn:0,btn: ['关闭'],btn1: function(index){
                    layer.close(index);
                },
                shadeClose: false, //开启遮罩关闭
                area: ['500px'],
                content: '<form class="layui-form" action="" style="width: 80%">'
                        +' <div class="layui-form-item">'
                        +' <label class="layui-form-label">发布人:</label>'
                        +' <div class="layui-input-block">'
                        +' <input type="text" name="title" disabled required  autocomplete="off" class="layui-input" value="'+notice.user.u_name+'('+status+')"> '
                        +' </div>'
                        +' </div>'
                        +' <div class="layui-form-item">'
                        +' <label class="layui-form-label">标题</label>'
                            +' <div class="layui-input-block">'
                            +' <input type="text" name="title" disabled required  autocomplete="off" class="layui-input" value="'+notice.n_titel+'"> '
                            +' </div>'
                        +' </div>'
                        +' <div class="layui-form-item layui-form-text">'
                        +' <label class="layui-form-label">内容</label> '
                            +'<div class="layui-input-block">'
                            +'<textarea name="desc" disabled class="layui-textarea">'+notice.n_content+'</textarea> '
                            +'</div> '
                        +' </div>'
                        +' <div class="layui-form-item"> '
                            +' <label class="layui-form-label">发布时间：</label> '
                            +' <div class="layui-inline">'
                            +' <input type="text" name="notice.n_date" disabled lay-verify="required" value="'+notice.n_date.substring(0,10)+'" class="layui-input"> '
                            +' </div> '
                        +' </div>'
                        +'</form>'
            });
        },"json");

    }

    //加载对象公告 读条完整信息
    function toUpdateNoticeBtn(nno) {
        var showUpdateDiv = `<div id="showUpdateNoticeDiv">
            <form class="layui-form"  id="updateNoticeForm" action="" >
            <input name="notice.n_no" type="hidden"/>
            <input name="notice.user.u_no" type="hidden"/>
            <div class="layui-form-item">
            <label class="layui-form-label">标&nbsp;题&nbsp;：</label>
        <div class="layui-input-inline">
            <input type="text" name="notice.n_titel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
            </div>
            <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">详细内容：</label>
        <div class="layui-input-block" >
            <textarea name="notice.n_content" lay-verify="required" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">创建时间：</label>
        <div class="layui-inline">
            <input type="text" name="notice.n_date" lay-verify="required" placeholder="点击选择时间" class="layui-input" id="noticeInputDateId">
            </div>
            </div>
            <div class="layui-form-item">
            <div class="layui-input-block">
                <div class="layui-btn" lay-submit lay-filter="formDemo">点击修改</div>
            </div>
            </div>
            </form><div>`;

        $.get("noticeAction_toUpdateNotice?notice.n_no="+nno,"",function (data) {
            var notice = data.notice;
            $("#showUpdateNoticeDiv input[name='notice.n_titel']").val(notice.n_titel);
            $("#showUpdateNoticeDiv textarea[name='notice.n_content']").val(notice.n_content);
            $("#showUpdateNoticeDiv input[name='notice.n_date']").val(notice.n_date.substring(0,10));
            $("#showUpdateNoticeDiv input[name='notice.n_no']").val(notice.n_no);
            $("#showUpdateNoticeDiv input[name='notice.user.u_no']").val(notice.user.u_no);
        },"json");

        var updateNoticeOpen = layer.open({
            type: 1,
            skin: 'layui-layer-molv',//样式类名
            title:'公告详细信息',
            anim: 1,
            closeBtn:1,
            shadeClose: true, //开启遮罩关闭
            area: ['500px'],
            content:showUpdateDiv
        })
        form.on('submit(formDemo)', function(data){
            //layer.msg(JSON.stringify(data.field));
            $.post("noticeAction_doUpdateNotice",data.field,function (data) {
                if(data.msg==1){
                    layer.msg("修改成功");
                    layer.close(updateNoticeOpen);
                }else if (data.msg==0){
                    layer.msg("修改失败");
                }
                loadData();
            },"json");

        });
        laydate.render({
            elem: '#noticeInputDateId'
        })




    }
    //关闭修改框的js
    function closeShowDiv() {
        $("#showUpdateTitel").html("").empty();
        $("#showUpdateNoticeDiv :not(input[id='doUpdateNoticeBtnId'],input[id='closeUpdateNoticeBtnId'])").val("");
        $("#showUpdateNoticeDiv").hide();
        //$("#showUpdateNoticeDiv input[name='notice.n_no']").remove();
    }

    //执行修改公告内容
    function doUpdateNoticeBtn() {
        $("#showUpdateTitel").html("").empty();
        var param = $("#updateNoticeForm").serialize();
       /* $.post("noticeAction_doUpdateNotice",param,function (data) {
            var font = null;
            if(data.msg==1){
                font ="<h4>执行修改成功</h4>";
            }else if(data.msg==0){
                font ="<h4>执行修改失败</h4>";
            }
            $("#showUpdateTitel").append(font);
            loadData();
        },"json");*/
    }

    //删除公告信息
    function doDelNoticeBtn(nno) {
        layer.confirm('确定要删除吗？',{title:'删除公告'},function(index){
            layer.close(index);
            $.post("noticeAction_delNotice?notice.n_no="+nno, "", function (data) {
                if (data.msg == 1) {
                    layer.msg("删除成功");
                } else if (data.msg == 0) {
                    layer.msg("删除失败");
                }
                loadData();
            },"json");
        });

       /* $("#titleDiv").html("").empty();
        if (confirm("确定要删除吗？")) {
            $.post("noticeAction_delNotice?notice.n_no="+nno, "", function (data) {
                var font = null;
                if (data.msg == 1) {
                    font = "<h3>删除成功</h3>";
                } else if (data.msg == 0) {
                    font = "<h3>删除失败</h3>";
                }
                $("#titleDiv").append(font);
                loadData();
            },"json");
        }*/
    }

    //普通员工查看的具体内容
    function selectNoticeBtn(nno){
        if($("#showSelectNoticeDiv").css("display")=="none"){
            $("#showSelectNoticeDiv").show();
            $.get("noticeAction_toUpdateNotice?notice.n_no="+nno,"",function (data) {
             var notice = data.notice;
             $("#showSelectNoticeDiv input[name='notice.n_titel']").val(notice.n_titel);
             $("#showSelectNoticeDiv textarea[name='notice.n_content']").val(notice.n_content);
             $("#showSelectNoticeDiv input[name='notice.n_date']").val(notice.n_date.substring(0,10));
             },"json");
        }else{
            closeShowSelectDiv();
        }
    }
    function closeShowSelectDiv() {
        $("#showSelectNoticeDiv :not(input[id='closeSelectNoticeBtnId'])").val("");
        $("#showSelectNoticeDiv").hide();
    }



</script>
