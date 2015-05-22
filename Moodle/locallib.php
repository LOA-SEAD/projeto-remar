<?php
// This file is part of Moodle - http://moodle.org/
//
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
 * Internal library of functions for module remar
 *
 * All the remar specific functions, needed to implement the module
 * logic, should go here. Never include this file from your lib.php!
 *
 * @package    mod_remar
 * @copyright  2015 REner Baffa da Silva <renerbaffa@gmail.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */


if (!defined('MOODLE_INTERNAL')) {
    die(get_string('forbidden_access'));
}

/*
 * Does something really useful with the passed things
 *
 * @param array $things
 * @return object
 *function remar_do_something_useful(array $things) {
 *    return new stdClass();
 *}
 */

function remar_quiforca_update($userid, $cm, $instanceid, $quiforca_data) {
    echo '<pre>';
    var_dump($quiforca_data);
    echo '</pre>';
    die();
}