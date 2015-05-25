<?php

// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.
/**
 * Web service local plugin template external functions and service definitions.
 *
 * @package    localwstemplate
 * @copyright  2015 Rener Baffa da Silva <renerbaffa@gmail.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
// We defined the web service functions to install.
$functions = array(
    'mod_remar_quiforca_update' => array(
        'classname'   => 'mod_remar_external', //class name
        'methodname'  => 'quiforca_update',
        'classpath'   => 'mod/remar/externallib.php',
        'description' => 'Atualiza ou adiciona um dado de tentativa do usuário.',
        'type'        => 'write',
    )
);
// We define the services to install as pre-build services. A pre-build service is not editable by administrator.
$services = array(
    'remar_service' => array(
        'functions' => array ('mod_remar_quiforca_update'),
        'restrictedusers' => 0,
        'enabled'=>1,
    )
);