<?php
    /*
     * [������� ��û ������]
     *
     * LG�ڷ������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ ��� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG�ڷ������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    $CST_PLATFORM               = $HTTP_POST_VARS["CST_PLATFORM"];       //LG�ڷ��� ���� ���� ����(test:�׽�Ʈ, service:����)
    $CST_MID                    = $HTTP_POST_VARS["CST_MID"];            //�������̵�(LG�ڷ������� ���� �߱޹����� �������̵� �Է��ϼ���)
                                                                         //�׽�Ʈ ���̵�� 't'�� �ݵ�� �����ϰ� �Է��ϼ���.
    $LGD_MID                    = (("test" == $CST_PLATFORM)?"t":"").$CST_MID;  //�������̵�(�ڵ�����)    
    $LGD_TID                	= $HTTP_POST_VARS["LGD_TID"];			 //LG�ڷ������� ���� �������� �ŷ���ȣ(LGD_TID)
    
 	$configPath 				= "C:/lgdacom"; 						 //LG�ڷ��޿��� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.   
    
    require_once("./lgdacom/XPayClient.php");
    $xpay = &new XPayClient($configPath, $CST_PLATFORM);
    $xpay->Init_TX($LGD_MID);

    $xpay->Set("LGD_TXNAME", "Cancel");
    $xpay->Set("LGD_TID", $LGD_TID);
    
    /*
     * 1. ������� ��û ���ó��
     *
     * ��Ұ�� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
    if ($xpay->TX()) {
        //1)������Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        echo "���� ��ҿ�û�� �Ϸ�Ǿ����ϴ�.  <br>";
        echo "TX Response_code = " . $xpay->Response_Code() . "<br>";
        echo "TX Response_msg = " . $xpay->Response_Msg() . "<p>";
    }else {
        //2)API ��û ���� ȭ��ó��
        echo "���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>";
        echo "TX Response_code = " . $xpay->Response_Code() . "<br>";
        echo "TX Response_msg = " . $xpay->Response_Msg() . "<p>";
    }
?>
