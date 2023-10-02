<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="imui" uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="imart"
    uri="http://www.intra-mart.co.jp/taglib/core/standard"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>





<imui:head>
    <title>Untitled</title>
    <script src="ui/libs/jquery-validation-1.9.0/jquery.validate.js"></script>
    <script type="text/javascript">
        var rules = {
            name : {
                required : true
            },
            price : {
                required : true
            },
            stockquantity : {
                required : true
            },
            category : {
                required : true
            }
        };
        var messages = {
            name : {
                required : "Plese input the product name !"
            },
            price : {
                required : "Please input price !"
            },
            stockquantity : {
                required : "Please input quantity !"
            },
            category : {
                required : "Please select the category !"
            }
        };
        $(function() {
            $('#insertbutton').click(
                    function() {
                        console.log("masuk form");
                        if (!imuiValidate('#insertForm', rules, messages))
                            return;
                        console.log("beres form");
                        $("#insertForm").attr("action", "product/insert/data");
                        imuiAjaxSend("#insertForm", "POST", "json", $.noop,
                                $.noop, true, 10000, false, function(
                                        returnObject) {
                                    if (!returnObject.parameters.init) {
                                        // clear the input
                                        $("#name").val("");
                                        $("#price").val("");
                                        $("#stockquantity").val("");
                                        $("#supervisor_incentive").val("");
                                    }
                                });
                        return false;
                    });
            
            $("#clearbutton").click(()=>{
                $("#name").val("");
                $("#price").val("");
                $("#stockquantity").val("");
            })
        });

        function callbackSuccess_contract(e, data) {
            console.log(e)
            console.log(data)
            var file = data.files[0];
            var fileName = file.name;
            var fileSize = file.size;
            var fileType = file.type;

            var receiveFile = data.result[0];
            var receiveFileName = receiveFile.name;
            var receivePhysicalFileName = receiveFile.physicalName;
            var receiveFileSize = receiveFile.size;
            var fileType = receiveFile.type;

            $(".contract_file_upload")
                    .prepend(
                            "<div class='"+ receivePhysicalFileName +"'>"
                                    + "<input type='hidden' value='0' id='f_contract_upload_file_id' name='f_contract_upload_file_id'>"
                                    + "<input type='hidden' value='"+ receiveFileName +"' id='f_contract_upload_file_name' name='f_contract_upload_file_name'>"
                                    + "<input type='hidden' value='"+ receivePhysicalFileName +"' id='f_contract_upload_file_real_name' name='f_contract_upload_file_real_name'>"
                                    + "</div>");
        }

        function callbackRemove_contract(e, data) {
            var file = data.response[0];
            var fileName = file.name;

            $("." + fileName).remove();
        }

        function callbackError_contract(e, data) {
            var file = data.files[0];
            var fileName = file.name;
            var fileSize = file.size;
            var fileType = file.type;
        }
    </script>
</imui:head>
<!-- 画面タイトル -->
<div class="imui-title">
    <h1 id="h1">Insert New Product 11</h1>
</div>
<!-- ツールバー -->
<div class="imui-toolbar-wrap">
    <div class="imui-toolbar-inner">
        <ul class="imui-list-toolbar">
            <!-- 戻るボタン -->
            <li><a href="#" class="imui-toolbar-icon" title="Back"><span
                    class="im-ui-icon-common-16-back"></span></a></li>
        </ul>
    </div>
</div>
<!-- コンテンツエリア -->
<div class="imui-form-container-narrow">
    <!-- h2 -->
    <div class="imui-chapter-title">
        <h2>Insert New Product</h2>
    </div>
    <form:form id="insertForm" name="insertForm" method="POST"
        class="target_form mt-10" action="product/insert/data"
        modelAttribute="insertProductData">
        <table class="imui-form">
            <tbody>
                <tr>
                    <th><label>Product Name</label></th>
                    <td><imui:textbox id="name" name="name" style="width: 200px;" /></td>
                </tr>
                <tr>
                    <th><label>Category</label></th>
                    <td><select name="category" id="category_name"
                        style="width: 212px;">
                            <option value="" selected disabled>Select Category :</option>
                            <option value="sepatuLari">Sepatu Lari</option>
                            <option value="sepatuFutsal">Sepatu Futsal</option>
                            <option value="sepatuBola">Sepatu Bola</option>
                            <option value="sepatuBadminton">Sepatu Badminton</option>
                            <option value="kaosJersey">Kaos jersey</option>
                            <option value="celanaPendekJersey">Celana Pendek Jersey</option>
                            <option value="celanaTraining">Celana Training</option>
                            <option value="jaketTraining">Jaket Training</option>
                            <option value="bolaFutsal">Bola Futsal</option>
                            <option value="bolaBasket">Bola Basket</option>
                            <option value="shuttleCock">ShuttleCock</option>
                    </select></td>
                </tr>
                <tr>
                    <th><label for="price">Price</label></th>
                    <td><input type="number" id="price" name="price"
                        style="width: 200px;"></td>
                </tr>
                <tr>
                    <th><label for="quantity">Quantity</label></th>
                    <td><input type="number" id="stockquantity"
                        name="stockquantity" style="width: 200px;"></td>
                </tr>
            </tbody>
        </table>

    </form:form>


    <table class="imui-form">
        <tbody>
            <tr>
                <th width="200"><label class="imui-required">Upload
                        File</label></th>
                <td><imui:fileUpload enableDelete="true" uniqueFileName="true"
                        storeTo="gpr_contract_flow/" onSuccess="callbackSuccess_contract"
                        onError="callbackError_contract"
                        onRemove="callbackRemove_contract" /></td>
            </tr>
        </tbody>
    </table>

    <div class="imui-operation-parts">
        <imui:button value="Submit" id="insertbutton"
            class="imui-large-button" />
        <imui:button value="Clear" id="clearbutton"
        class="imui-large-button" />
    </div>
</div>