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
        return new external_function_parameters(
            array('PARAM1' => new external_value(PARAM_TEXT, 'The welcome message. By default it is "Hello world,"', VALUE_DEFAULT, 'Hello world, '))
        );
    }
 
    /**
     * The function itself
     * @return string welcome message
     */
    public static function quiforca_update($PARAM1) {
 
        //Parameters validation
        $params = self::validate_parameters(self::quiforca_update_parameters(),
                array('PARAM1' => $PARAM1));
 
        //Note: don't forget to validate the context and check capabilities
 
        return $params['PARAM1'];
    }
 
    /**
     * Returns description of method result value
     * @return external_description
     */
    public static function quiforca_update_returns() {
        return new external_value(PARAM_TEXT, 'The welcome message + user first name');
    }
}