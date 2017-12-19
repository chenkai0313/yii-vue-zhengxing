<?php

Yii::setAlias('@common', dirname(__DIR__));
Yii::setAlias('@frontend', dirname(dirname(__DIR__)) . '/frontend');
Yii::setAlias('@backend', dirname(dirname(__DIR__)) . '/backend');
Yii::setAlias('@console', dirname(dirname(__DIR__)) . '/console');
define('DUMP', 1); //开启baseController的可视化数组打印函数
define('CERT_PATH', dirname(dirname(__DIR__)) . '/cert');
error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);
