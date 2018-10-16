<html>
<head>
    <title>Get Methods Tool</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <script src="https://code.jquery.com/jquery.js"></script>
</head>
<script type="text/javascript" language="javascript">
    // function disabledInput() {
    //     document.horizontal.country.disabled = true;
    //     document.horizontal.country.readOnly = true;
    //     document.horizontal.currency.disabled = true;
    //     document.horizontal.currency.disabled = true;
    // }
    //
    // function disabledThread() {
    //     document.horizontal.thread_number.disabled = true;
    //     document.horizontal.thread_number.readOnly = true;
    // }

    function reload() {
        window.location.reload();
    }

</script>

<script type="text/javascript" language="javascript">
    function postRequest() {
        // var disableCountry = document.horizontal.country.disabled;
        // if (disableCountry) {
        noneDisplayResponseBlock();
        submitMultiThread();
        // } else {
        //     submitSignalThread();
        // }
    }

    function submitSignalThread() {
        var env = $("#env").val();
        var country = $("#country").val();
        var currency = $("#currency").val();
        $.ajax({
            url: "/getMethods",
            method: "POST",
            dataType: "JSON",
            contentType: "application/x-www-form-urlencoded",
            data: {
                env: env,
                country: country,
                currency: currency
            },
            success: function (data) {
                if (data.code == 0) {
                    changeBackground(data.code);
                    $("#signalContent").html(data.data);
                } else {
                    changeBackground(data.code);
                    $("#signalContent").html(data.message);
                }
                $("#signalResult").show();
            },
            error: function (data) {
                alert("system error , please contact with system manager");
            }
        });
    }

    function changeBackground(code) {
        if (code == 0) {
            document.getElementById("signal-result").style.background = "#29980db5";
        } else {
            document.getElementById("signal-result").style.background = "#ff3100b5";
        }
    }

    function submitMultiThread() {
        var env = $("#env").val();
        // var threadNumber = $("#thread_number").val();
        $.ajax({
            url: "/dashboard/getPerformanceMethods",
            method: "POST",
            dataType: "JSON",
            contentType: "application/x-www-form-urlencoded",
            data: {
                env: env,
                // threadNumber: threadNumber
            },
            success: function (data) {
                if (data.code == 0) {
                    var successBodyStr = "";
                    var errorBodyStr = "";
                    var errorList = (data.data).errorList;
                    if (errorList.length == 0) {
                        displayErrorList(true);
                    } else {
                        displayErrorList(false);
                    }
                    for (var i = 0; i < errorList.length; i++) {
                        errorBodyStr = errorBodyStr + "<tr><td>" + errorList[i].country
                            + "</td><td>" + errorList[i].currency
                            + "</td><td>" + errorList[i].checks
                            + "</td></tr>";

                    }

                    $("#errorTBody").html(errorBodyStr);
                    var successList = (data.data).successList;
                    if (successList.length == 0) {
                        displayNormalList(true);
                    } else {
                        displayNormalList(false);
                    }
                    for (var i = 0; i < successList.length; i++) {
                        successBodyStr = successBodyStr + "<tr><td>" + successList[i].country
                            + "</td><td>" + successList[i].currency
                            + "</td><td>" + successList[i].checks
                            + "</td></tr>";
                    }

                    $("#successTBody").html(successBodyStr);
                    $("#multiResult").show();
                } else {

                }

            },
            error: function (data) {
                alert("system error , please contact with system manager");
            }
        });
    }

    function ignoreData() {
        // var flag = false;
        // var i = 0;
        // var idList = "";
        // $("input[type=checkbox]").each(function () {
        // if (this.checked == true) {
        //     if (i == 0) {
        //         i++;
        //     } else {
        //         flag = true;
        //         idList = idList + $(this).val() + ",";
        //         i++;
        //     }
        // }
        // });
        // if (!flag) {
        //     alert("please choose one recond to ignore");
        //     return;
        // }
        // submitIgnoreData(idList.substr(0, idList.length - 1));
        submitIgnoreData();
    }

    function submitIgnoreData() {
        $.ajax({
            url: "/dashboard/ignoreChecks",
            method: "POST",
            dataType: "JSON",
            contentType: "application/x-www-form-urlencoded",
            // data: {
            //     idList: idList
            // },

            success: function (data) {
                if (data.code == 0) {
                    // var check = $("#checkAll").checked;
                    // if (check) {
                    //     $("#exceptionTable tr").remove();
                    // } else {
                    //     $("input[type=checkbox]").each(function () {
                    //         if (this.checked == true) {
                    //             $(this).parent().parent().remove();
                    //         }
                    //     });
                    // }
                    displayErrorList(true);
                    alert("Success");
                } else {
                    alert(data.message);
                }
            },
            error: function (data) {

            }
        });
    }

    function noneDisplayResponseBlock() {
        document.getElementById("error-list").style.display = "none";
        document.getElementById("normal-list").style.display = "none";
    }

    function displayNormalList(flag) {
        if (flag) {
            document.getElementById("normal-list").style.display = "none";
        } else {
            document.getElementById("normal-list").style.display = "";
        }
    }

    function displayErrorList(flag) {
        if (flag) {
            document.getElementById("error-list").style.display = "none";
        } else {
            document.getElementById("error-list").style.display = "";
        }
    }

    function checkAll(obj) {
        if (obj.checked) {
            $("input[type=checkbox]").each(function () {
                $(this).attr("checked", true);
            });
        } else {
            $("input[type=checkbox]").each(function () {
                $(this).attr("checked", false);
            });
        }
    }
</script>
<body>
<div class="container" style="margin-top:30px">
    <form class="form-horizontal" name="horizontal" role="form">
        <fieldset>
            <legend>Data Configuration</legend>
            <div class="form-group">
                <label class="col-sm-2 control-label">ENV</label>
                <div class="col-sm-4">
                    <select id="env" class="form-control">
                        <option value="product">product</option>
                        <option value="test">test</option>
                        <option value="dev">dev</option>
                    </select>
                </div>
            </div>
        </fieldset>
        <%--<fieldset>--%>
        <%--<div class="form-group">--%>
        <%--<label class="col-sm-2 control-label" for="thread_number">Thread Number</label>--%>
        <%--<div class="col-sm-4">--%>
        <%--<input class="form-control" id="thread_number" name="thread_number" type="number" placeholder="10"--%>
        <%--onfocus="disabledInput()"/>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</fieldset>--%>
        <%--<fieldset>--%>
        <%--<div class="form-group">--%>
        <%--<label class="col-sm-2 control-label">Country</label>--%>
        <%--<div class="col-sm-4">--%>
        <%--<input class="form-control" id="country" name="country" type="text" placeholder="AS"--%>
        <%--onfocus="disabledThread()"/>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</fieldset>--%>
        <%--<fieldset>--%>
        <%--<div class="form-group">--%>
        <%--<label class="col-sm-2 control-label">Currency</label>--%>
        <%--<div class="col-sm-4">--%>
        <%--<input class="form-control" id="currency" name="currency" type="text" placeholder="AED"--%>
        <%--onfocus="disabledThread()"/>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</fieldset>--%>
        <fieldset>
            <div class="form-group">
                <label class="col-sm-2 control-label"></label>
                <div class="col-sm-2">
                    <button type="button" class="btn btn-success" name="commit" onclick="postRequest()">Commit</button>
                </div>
                <div class="col-sm-2">
                    <!-- 信息警告消息的上下文按钮 -->
                    <button type="reset" class="btn btn-warning" name="rest" onclick="reload()">Reset</button>
                </div>
            </div>
        </fieldset>
    </form>
    <legend>Report</legend>
    <div style="display: none;" id="signalResult" name="signalResult">
        <div class="form-group" name="formGroup">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-12" style="">
                <div class="panel panel-default">
                    <div class="panel-heading" name="result" id="signal-result" style="background:#29980db5;">
                        <h3 class="panel-title">
                            Result:
                        </h3>
                    </div>
                    <div class="panel-body" id="signalContent">

                    </div>

                </div>
            </div>

        </div>
    </div>
    <div style="display: none;" id="multiResult">


        <div class="form-group">

            <label class="col-sm-2 control-label">
            </label>
            <div class="col-sm-12" id="error-list" style="">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background:#ff3100b5;">
                        <h3 class="panel-title">
                            Abnormal List:
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="list-op" id="list_op">
                            <button type="reset" onclick="ignoreData()" class="btn btn-danger">Ignore</button>
                        </div>
                    </div>
                    <table id="exceptionTable" class="table table-bordered table-hover">
                        <thead>
                        <tr class="danger">
                            <th>country</th>
                            <th>currency</th>
                            <th>check</th>
                        </tr>
                        </thead>
                        <tbody id="errorTBody">
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-12" id="normal-list" style="">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background:#5cb85c;">
                        <h3 class="panel-title">
                            Normal List:
                        </h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr class="success">
                                <th>country</th>
                                <th>currency</th>
                                <th>check</th>
                            </tr>
                            </thead>
                            <tbody id="successTBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
</body>
</html>