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
 * Prints a particular instance of remar
 *
 * You can have a rather longer description of the file as well,
 * if you like, and it can span multiple lines.
 *
 * @package    mod_remar
 * @copyright  2015 Rener Baffa da Silva <renerbaffa@gmail.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

// Replace remar with the name of your module and remove this line.
require_once(dirname(__FILE__) . '/../../config.php');
require_once(dirname(dirname(dirname(__FILE__))).'/config.php');
require_once(dirname(__FILE__).'/lib.php');

$id = optional_param('id', 0, PARAM_INT); // Course_module ID, or
$n  = optional_param('n', 0, PARAM_INT);  // ... remar instance ID - it should be named as the first character of the module.

if ($id) {
    $cm         = get_coursemodule_from_id('remar', $id, 0, false, MUST_EXIST);
    $course     = $DB->get_record('course', array('id' => $cm->course), '*', MUST_EXIST);
    $remar  = $DB->get_record('remar', array('id' => $cm->instance), '*', MUST_EXIST);
} else if ($n) {
    $remar  = $DB->get_record('remar', array('id' => $n), '*', MUST_EXIST);
    $course     = $DB->get_record('course', array('id' => $remar->course), '*', MUST_EXIST);
    $cm         = get_coursemodule_from_instance('remar', $remar->id, $course->id, false, MUST_EXIST);
} else {
    error('You must specify a course_module ID or an instance ID');
}

require_login($course, true, $cm);

$event = \mod_remar\event\course_module_viewed::create(array(
    'objectid' => $PAGE->cm->instance,
    'context' => $PAGE->context,
));
$event->add_record_snapshot('course', $PAGE->course);
$event->add_record_snapshot($PAGE->cm->modname, $remar);
$event->trigger();

// Print the page header.

$PAGE->set_url('/mod/remar/view.php', array('id' => $cm->id));
$PAGE->set_title(format_string($remar->name));
$PAGE->set_heading(format_string($course->fullname));

/*
 * Other things you may want to set - remove if not needed.
 * $PAGE->set_cacheable(false);
 * $PAGE->set_focuscontrol('some-html-id');
 * $PAGE->add_body_class('remar-'.$somevar);
 */

// Output starts here.
echo $OUTPUT->header();

// Conditions to show the intro can change to look for own settings or whatever.
//$bla = $DB->get_records('remar');
//echo '<p>'.var_dump($bla).'</p>';

if ($remar->intro) {
    echo $OUTPUT->box(format_module_intro('remar', $remar, $cm->id), 'generalbox mod_introbox', 'remarintro');
}

/*$remar_content = '<p>'.get_string('test_activity_description', 'remar').'</p>';
$remar_content .= '<form method="get" action="grade.php">';
$remar_content .= '<input type="hidden" name="id" value="'.$cm->id.'" />';
$remar_content .= '<input type="hidden" name="userid" value="'.$USER->id.'" />';
$remar_content .= '<input type="number" name="questions" min="0" max="10" /><br />';
$remar_content .= '<input type="submit" />';
$remar_content .= '</form>';*/
/*$remar_content = '<div><iframe src="http://sistemas2.sead.ufscar.br/loa/QuiForca/" height="600" width="900" scrolling=no frameborder="0" /></div>';

echo $remar_content;*/

/*echo '<pre>';
var_dump($_SESSION);
echo '</pre>';*/


// Finish the page.
echo $OUTPUT->footer();
