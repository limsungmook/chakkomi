<?php
    /*
     * [���� ������û ������(STEP2-1)]
     *
     * ���������������� �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰� �Ͻñ� �ٶ��ϴ�.     
     */

    /*
     * 1. �⺻���� ������û ���� ����
     * 
     * �⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     */
    $CST_PLATFORM               = $HTTP_POST_VARS["CST_PLATFORM"];      //LG�ڷ��� ���� ���� ����(test:�׽�Ʈ, service:����)
    $CST_MID                    = $HTTP_POST_VARS["CST_MID"];           //�������̵�(LG�ڷ������� ���� �߱޹����� �������̵� �Է��ϼ���)
                                                                        //�׽�Ʈ ���̵�� 't'�� �ݵ�� �����ϰ� �Է��ϼ���.
    $LGD_MID                    = (("test" == $CST_PLATFORM)?"t":"").$CST_MID;  //�������̵�(�ڵ�����)
    $LGD_OID                    = $HTTP_POST_VARS["LGD_OID"];           //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    $LGD_AMOUNT                 = $HTTP_POST_VARS["LGD_AMOUNT"];        //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    $LGD_BUYER                  = $HTTP_POST_VARS["LGD_BUYER"];         //�����ڸ�
    $LGD_PRODUCTINFO            = $HTTP_POST_VARS["LGD_PRODUCTINFO"];   //��ǰ��
    $LGD_BUYEREMAIL             = $HTTP_POST_VARS["LGD_BUYEREMAIL"];    //������ �̸���
    $LGD_CUSTOM_FIRSTPAY        = $HTTP_POST_VARS["LGD_CUSTOM_FIRSTPAY"];    //�������� �ʱ��������
    $LGD_TIMESTAMP              = date(YmdHms);                         //Ÿ�ӽ�����
    $LGD_CUSTOM_SKIN            = "blue";                               //�������� ����â ��Ų (red, blue, cyan, green, yellow)
    
	$configPath 				= "C:/lgdacom"; 						//LG�ڷ��޿��� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����. 	    
    
    /*
     * �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. 
     */    
    $LGD_CASNOTEURL				= "http://����URL/cas_noteurl.php";    

    /*
     * LGD_RETURNURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. �ݵ�� ���� �������� ������ ����Ʈ�� ��  ȣ��Ʈ�̾�� �մϴ�. �Ʒ� �κ��� �ݵ�� �����Ͻʽÿ�.
     */    
    $LGD_RETURNURL				= "http://����URL/returnurl.php";  
	
    /*
     * ISP ī����� ������ �����ISP���(�������� ���������ʴ� �񵿱���)�� ���, LGD_KVPMISPNOTEURL/LGD_KVPMISPWAPURL/LGD_KVPMISPCANCELURL�� �����Ͽ� �ֽñ� �ٶ��ϴ�. 
     */    
    $LGD_KVPMISPNOTEURL       	= "http://����URL/note_url.php";
    $LGD_KVPMISPWAPURL			= "http://����URL/mispwapurl.php?LGD_OID=".$LGD_OID;
    $LGD_KVPMISPCANCELURL     	= "http://����URL/cancel_url.php";
    
    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - BEGIN
     * 
     * MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�. 
     *************************************************
     *
     * �ؽ� ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : �������̵�
     * LGD_OID          : �ֹ���ȣ
     * LGD_AMOUNT       : �ݾ�
     * LGD_TIMESTAMP    : Ÿ�ӽ�����
     * LGD_MERTKEY      : ����MertKey (mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
     *
     * MD5 �ؽ������� ��ȣȭ ������ ����
     * LG�ڷ��޿��� �߱��� ����Ű(MertKey)�� ȯ�漳�� ����(lgdacom/conf/mall.conf)�� �ݵ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    require_once("./lgdacom/XPayClient.php");
    $xpay = &new XPayClient($configPath, $LGD_PLATFORM);
   	$xpay->Init_TX($LGD_MID);
    $LGD_HASHDATA = md5($LGD_MID.$LGD_OID.$LGD_AMOUNT.$LGD_TIMESTAMP.$xpay->config[$LGD_MID]);
    $LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - END
     *************************************************
     */
?>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>�ڷ��� eCredit���� �����׽�Ʈ</title>
<script language="javascript" src="http://xpay.lgdacom.net/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">


/*
* iframe���� ����â�� ȣ���Ͻñ⸦ ���Ͻø� iframe���� ���� (������ ���� �Ұ�)
*/
	var LGD_window_type = "iframe"; 
/*
* �����Ұ�
*/
function launchCrossPlatform(){
      lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '<?= $CST_PLATFORM ?>', LGD_window_type);
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}
/*
* �Ϲݿ� ��������(�Լ����� ���� �Ұ�)
*/
function setLGDResult(){
	if( LGD_window_type == 'iframe' ){
		document.getElementById('LGD_PAYMENTWINDOW').style.display = "none";
		document.getElementById('LGD_RESPCODE').value = lgdwin.contentWindow.document.getElementById('LGD_RESPCODE').value; 
		document.getElementById('LGD_RESPMSG').value = lgdwin.contentWindow.document.getElementById('LGD_RESPMSG').value;
		if(lgdwin.contentWindow.document.getElementById('LGD_PAYKEY') != null){
			document.getElementById('LGD_PAYKEY').value = lgdwin.contentWindow.document.getElementById('LGD_PAYKEY').value;
		}
	}  else {
		document.getElementById('LGD_RESPCODE').value = lgdwin.document.getElementById('LGD_RESPCODE').value; 
		document.getElementById('LGD_RESPMSG').value = lgdwin.document.getElementById('LGD_RESPMSG').value;
		if(lgdwin.document.getElementById('LGD_PAYKEY') != null){
			document.getElementById('LGD_PAYKEY').value = lgdwin.document.getElementById('LGD_PAYKEY').value;
		}
	}
	
	if(document.getElementById('LGD_RESPCODE').value == '0000' ){
		getFormObject().target = "_self";
		getFormObject().action = "payres.php";
		getFormObject().submit();
	} else {
		alert(document.getElementById('LGD_RESPMSG').value);
	}
	
}
/*
* ����Ʈ���� ��������(�Լ����� ���� �Ұ�)
*/

function doSmartXpay(){

        var LGD_RESPCODE        = dpop.getData('LGD_RESPCODE');       //����ڵ�
        var LGD_RESPMSG         = dpop.getData('LGD_RESPMSG');        //����޼���

        if( "0000" == LGD_RESPCODE ) { //��������
            var LGD_PAYKEY      = dpop.getData('LGD_PAYKEY');         //LG�ڷ��� ����KEY
            document.getElementById('LGD_PAYKEY').value = LGD_PAYKEY;
            getFormObject().submit();
        } else { //��������
            alert("������ �����Ͽ����ϴ�. " + LGD_RESPMSG);
        }
        
}

</script>
</head>
<body>

<!--  ���� �Ұ�(IFRAME ��Ľ� ���)   -->
<div id="LGD_PAYMENTWINDOW" style="position:absolute; display:none; width:100%; height:100%; z-index:100 ;background-color:#D3D3D3; font-size:small; ">
     <iframe id="LGD_PAYMENTWINDOW_IFRAME" name="LGD_PAYMENTWINDOW_IFRAME" height="100%" width="100%" scrolling="no" frameborder="0">
     </iframe>
</div>

 

<form method="post" id="LGD_PAYINFO" action="payres.php">
<table>
    <tr>
        <td>������ �̸� </td>
        <td><?= $LGD_BUYER ?></td>
    </tr>
    <tr>
        <td>��ǰ���� </td>
        <td><?= $LGD_PRODUCTINFO ?></td>
    </tr>
    <tr>
        <td>�����ݾ� </td>
        <td><?= $LGD_AMOUNT ?></td>
    </tr>
    <tr>
        <td>������ �̸��� </td>
        <td><?= $LGD_BUYEREMAIL ?></td>
    </tr>
    <tr>
        <td>�ֹ���ȣ </td>
        <td><?= $LGD_OID ?></td>
    </tr>
    <tr>
        <td colspan="2">* �߰� �� ������û �Ķ���ʹ� �޴����� �����Ͻñ� �ٶ��ϴ�.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>    
    <tr>
        <td colspan="2">
		<input type="button" value="������û" onclick="launchCrossPlatform();"/>         
        </td>
    </tr>    
</table>
<br>

<br>
<input type="hidden" name="CST_PLATFORM"                value="<?= $CST_PLATFORM ?>">                   <!-- �׽�Ʈ, ���� ���� -->
<input type="hidden" name="CST_MID"                     value="<?= $CST_MID ?>">                        <!-- �������̵� -->
<input type="hidden" name="LGD_MID"                     value="<?= $LGD_MID ?>">                        <!-- �������̵� -->
<input type="hidden" name="LGD_OID"                     value="<?= $LGD_OID ?>">                        <!-- �ֹ���ȣ -->
<input type="hidden" name="LGD_BUYER"                   value="<?= $LGD_BUYER ?>">           			<!-- ������ -->
<input type="hidden" name="LGD_PRODUCTINFO"             value="<?= $LGD_PRODUCTINFO ?>">     			<!-- ��ǰ���� -->
<input type="hidden" name="LGD_AMOUNT"                  value="<?= $LGD_AMOUNT ?>">                     <!-- �����ݾ� -->
<input type="hidden" name="LGD_BUYEREMAIL"              value="<?= $LGD_BUYEREMAIL ?>">                 <!-- ������ �̸��� -->
<input type="hidden" name="LGD_CUSTOM_SKIN"             value="<?= $LGD_CUSTOM_SKIN ?>">                <!-- ����â SKIN -->
<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"      value="<?= $LGD_CUSTOM_PROCESSTYPE ?>">         <!-- Ʈ����� ó����� -->
<input type="hidden" name="LGD_TIMESTAMP"               value="<?= $LGD_TIMESTAMP ?>">                  <!-- Ÿ�ӽ����� -->
<input type="hidden" name="LGD_HASHDATA"                value="<?= $LGD_HASHDATA ?>">                   <!-- MD5 �ؽ���ȣ�� -->
<input type="hidden" name="LGD_RETURNURL"   			value="<?= $LGD_RETURNURL ?>">      			<!-- �������������--> 
<input type="hidden" name="LGD_VERSION"         		value="PHP_SmartXPay_1.0">				   	    <!-- �������� (�������� ������) -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"  		value="<?= $LGD_CUSTOM_FIRSTPAY ?>">								    <!-- ����Ʈ �������� -->

<!-- �������(������) ���������� �Ͻô� ���  �Ҵ�/�Ա� ����� �뺸�ޱ� ���� �ݵ�� LGD_CASNOTEURL ������ LG �ڷ��޿� �����ؾ� �մϴ� . -->
<!-- input type="hidden" name="LGD_CASNOTEURL"          	value="<?= $LGD_CASNOTEURL ?>"-->			<!-- ������� NOTEURL -->  

<!-- 
****************************************************
* �ȵ���̵��� �ſ�ī�� ISP(����/BC)�������� ���� (����)*
****************************************************

(����)LGD_CUSTOM_ROLLBACK �� ����  "Y"�� �ѱ� ���, LG U+ ���ڰ������� ���� ISP(����/��) ���������� �������� note_url���� ���Ž�  "OK" ������ �ȵǸ�  �ش� Ʈ�������  ������ �ѹ�(�ڵ����)ó���ǰ�, 
LGD_CUSTOM_ROLLBACK �� �� �� "C"�� �ѱ� ���, �������� note_url���� "ROLLBACK" ������ �� ���� �ش� Ʈ�������  �ѹ�ó���Ǹ�  �׿��� ���� ���ϵǸ� ���� ���οϷ� ó���˴ϴ�.
����, LGD_CUSTOM_ROLLBACK �� ���� "N" �̰ų� null �� ���, �������� note_url����  "OK" ������  �ȵɽ�, "OK" ������ �� ������ 3�а������� 2�ð�����  ���ΰ���� �������մϴ�.   
-->

<input type="hidden" name="LGD_CUSTOM_ROLLBACK"         value="">				   	   				   <!-- �񵿱� ISP���� Ʈ����� ó������ -->
<input type="hidden" name="LGD_KVPMISPNOTEURL"  		value="<?= $LGD_KVPMISPNOTEURL ?>">			   <!-- �񵿱� ISP(ex. �ȵ���̵�) ���ΰ���� �޴� URL -->
<input type="hidden" name="LGD_KVPMISPWAPURL"  			value="<?= $LGD_KVPMISPWAPURL ?>">			   <!-- �񵿱� ISP(ex. �ȵ���̵�) ���οϷ��� ����ڿ��� �������� ���οϷ� URL -->
<input type="hidden" name="LGD_KVPMISPCANCELURL"  		value="<?= $LGD_KVPMISPCANCELURL ?>">		   <!-- ISP �ۿ��� ��ҽ� ����ڿ��� �������� ��� URL -->

<!-- 
****************************************************
* �ȵ���̵��� �ſ�ī�� ISP(����/BC)�������� ����    (��) *
****************************************************
-->

<!-- input type="hidden" name="LGD_KVPMISPAUTOAPPYN"         value="Y"> --> 
<!-- Y: ���������� ISP�ſ�ī�� ������, ���翡�� 'App To App' ������� ����, BCī��翡�� ���� ���� ������ �ް� ������ ���� �����ϰ��� �Ҷ� ���-->


<!-- ���� �Ұ� ( ���� �� �ڵ� ���� ) -->
<input type="hidden" name="LGD_RESPCODE" id="LGD_RESPCODE">
<input type="hidden" name="LGD_RESPMSG" id="LGD_RESPMSG">
<input type="hidden" name="LGD_PAYKEY"  id="LGD_PAYKEY">      
</form>
</body>
</html>

