<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require_once($CFG->libdir . "/externallib.php");

class mod_remar_external extends external_api {
    /**
     * Returns description of method parameters
     * @return external_function_parameters
     */
    public static function quiforca_update_parameters() {
        /*return new external_function_parameters(
            array('PARAM1' => new external_value(PARAM_TEXT, 'The welcome message. By default it is "Hello world,"', VALUE_DEFAULT, 'Hello world, '))
        );*/
        
        return new external_function_parameters (
            array ( 
                'params' => new external_single_structure (
                    array(
                        'userid' => new external_value(PARAM_INT, 'ID do usuário', VALUE_REQUIRED),
                        'cm' => new external_value(PARAM_INT, 'ID do módulo do curso (course module - cm)', VALUE_REQUIRED),
                        'instance_id' => new external_value(PARAM_INT, 'ID da instância do game', VALUE_REQUIRED),
                        'dica' => new external_value(PARAM_TEXT, 'Dica para acertar a palavra', VALUE_REQUIRED),
                        'palavra' => new external_value(PARAM_TEXT, 'Palavra que é a resposta', VALUE_REQUIRED),
                        'contribuicao' => new external_value(PARAM_TEXT, 'Pessoa que contribuiu para a criação desta palavra', VALUE_REQUIRED),
                        'letra_escolhida' => new external_value(PARAM_TEXT, 'Armazena a letra escolhida (jogada)', VALUE_REQUIRED),
                        'timestamp' => new external_value(PARAM_ALPHANUMEXT, 'Timestamp de quando foi feita a jogada', VALUE_REQUIRED)
                    )
                )
            )
        );
        
        /*return new external_function_parameters (
            array (
                'params' => new external_multiple_structure (
                    new external_single_structure (
                        array (
                            'userid' => new external_value(PARAM_INT, 'ID do usuário', VALUE_REQUIRED),
                            'cm' => new external_value(PARAM_INT, 'ID do módulo do curso (course module - cm)', VALUE_REQUIRED),
                            'instanceid' => new external_value(PARAM_INT, 'ID da instância do game', VALUE_REQUIRED),
                            'dica' => new external_value(PARAM_TEXT, 'Dica para acertar a palavra', VALUE_REQUIRED),
                            'palavra' => new external_value(PARAM_TEXT, 'Palavra que é a resposta', VALUE_REQUIRED),
                            'contribuicao' => new external_value(PARAM_TEXT, 'Pessoa que contribuiu para a criação desta palavra', VALUE_REQUIRED),
                            'letra_escolhida' => new external_value(PARAM_TEXT, 'Armazena a letra escolhida (jogada)', VALUE_REQUIRED),
                            'timestamp' => new external_value(PARAM_ALPHANUMEXT, 'Timestamp de quando foi feita a jogada', VALUE_REQUIRED),                            
                        )
                    )
                )
            )
        );*/
    }
 
    /**
     * The function itself
     * @return string welcome message
     */
    public static function quiforca_update($params) {
        global $DB;
        
        //Parameters validation
        $validated_params = self::validate_parameters(self::quiforca_update_parameters(), array('params' => $params));
 
        $lastinsertid = $DB->insert_record('remar_quiforca', $params);
 
        $ret = array (
            'code' => $lastinsertid,
            'description' => 'ID do último item inserido no banco'
        );
        
        return $ret;
    }
 
    /**
     * Returns description of method result value
     * @return external_description
     */
    public static function quiforca_update_returns() {
        /*return new external_single_structure (
            array(
                'userid' => new external_value(PARAM_INT, 'ID do usuário'),
                'cm' => new external_value(PARAM_INT, 'ID do módulo do curso (course module - cm)'),
                'instance_id' => new external_value(PARAM_INT, 'ID da instância do game'),
                'dica' => new external_value(PARAM_TEXT, 'Dica para acertar a palavra'),
                'palavra' => new external_value(PARAM_TEXT, 'Palavra que é a resposta'),
                'contribuicao' => new external_value(PARAM_TEXT, 'Pessoa que contribuiu para a criação desta palavra'),
                'letra_escolhida' => new external_value(PARAM_TEXT, 'Armazena a letra escolhida (jogada)'),
                'timestamp' => new external_value(PARAM_ALPHANUMEXT, 'Timestamp de quando foi feita a jogada')
            )
        );*/
        return new external_single_structure(
            array (
                'code' => new external_value(PARAM_INT, 'Código do último item inserido no banco ou do erro causado.'),
                'description' => new external_value(PARAM_TEXT, 'Descrição')
            )
        );
    }
}