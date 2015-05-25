<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$token = '7e9da9bb83b1155c66a15c92bdfd7bed';
$domainname = 'localhost/moodle';

/// FUNCTION NAME
$functionname = 'mod_remar_quiforca_update';

/// PARAMETERS
/*$params['params'][0]['userid'] = 4;
$params['params'][0]['cm'] = 2;
$params['params'][0]['instanceid'] = 2;
$params['params'][0]['dica'] = 'Dica';
$params['params'][0]['palavra'] = 'palavra';
$params['params'][0]['contribuicao'] = 'Rener Baffa da Silva';
$params['params'][0]['letra_escolhida'] = 'j';
$now = new DateTime();
$now = $now->getTimestamp();
$params['params'][0]['timestamp'] = $now;*/



/*$params['userid'] = 4;
$params['cm'] = 2;
$params['instanceid'] = 2;
$params['dica'] = 'Dica';
$params['palavra'] = 'palavra';
$params['contribuicao'] = 'Rener Baffa da Silva';
$params['letra_escolhida'] = 'J';

$now = new DateTime();
$params['timestamp'] = $now->getTimestamp();*/

$now = new DateTime();
$params = array (
    'userid' => 4,
    'cm' => 2,
    'instance_id' => 2,
    'dica' => 'Dica',
    'palavra' => 'palavra',
    'contribuicao' => 'Rener Baffa da Silva',
    'letra_escolhida' => 'J',
    'timestamp' => $now->getTimestamp()
);



///// XML-RPC CALL
header('Content-Type: text/plain');
$serverurl = $domainname . '/webservice/xmlrpc/server.php'. '?wstoken=' . $token;
require_once('./curl.php');
$curl = new curl;
$post = xmlrpc_encode_request($functionname, array($params));
$resp = xmlrpc_decode($curl->post($serverurl, $post));
var_dump($resp);