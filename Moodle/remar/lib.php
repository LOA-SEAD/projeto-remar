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
 * Library of interface functions and constants for module remar
 *
 * All the core Moodle functions, neeeded to allow the module to work
 * integrated in Moodle should be placed here.
 *
 * All the remar specific functions, needed to implement all the module
 * logic, should go to locallib.php. This will help to save some memory when
 * Moodle is performing actions across all modules.
 *
 * @package    mod_remar
 * @copyright  2015 Rener Baffa da Silva <renerbaffa@gmail.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

/**
 * Example constant, you probably want to remove this :-)
 */
define('REMAR_ULTIMATE_ANSWER', 42);

/* Moodle core API */

/**
 * Returns the information on whether the module supports a feature
 *
 * See {@link plugin_supports()} for more info.
 *
 * @param string $feature FEATURE_xx constant for requested feature
 * @return mixed true if the feature is supported, null if unknown
 */
function remar_supports($feature) {

    switch($feature) {
        case FEATURE_MOD_INTRO:
            return true;
        case FEATURE_SHOW_DESCRIPTION:
            return true;
        case FEATURE_GRADE_HAS_GRADE:
            return true;
        case FEATURE_BACKUP_MOODLE2:
            return true;
        default:
            return null;
    }
}

/**
 * Saves a new instance of the remar into the database
 *
 * Given an object containing all the necessary data,
 * (defined by the form in mod_form.php) this function
 * will create a new instance and return the id number
 * of the new instance.
 *
 * @param stdClass $remar Submitted data from the form in mod_form.php
 * @param mod_remar_mod_form $mform The form instance itself (if needed)
 * @return int The id of the newly inserted remar record
 */
function remar_add_instance(stdClass $remar, mod_remar_mod_form $mform = null) {
    global $DB;

    $remar->timecreated = time();

    // You may have to add extra stuff in here.

    $remar->id = $DB->insert_record('remar', $remar);

    remar_grade_item_update($remar);

    return $remar->id;
}

/**
 * Updates an instance of the remar in the database
 *
 * Given an object containing all the necessary data,
 * (defined by the form in mod_form.php) this function
 * will update an existing instance with new data.
 *
 * @param stdClass $remar An object from the form in mod_form.php
 * @param mod_remar_mod_form $mform The form instance itself (if needed)
 * @return boolean Success/Fail
 */
function remar_update_instance(stdClass $remar, mod_remar_mod_form $mform = null) {
    global $DB;

    $remar->timemodified = time();
    $remar->id = $remar->instance;

    // You may have to add extra stuff in here.

    $result = $DB->update_record('remar', $remar);

    remar_grade_item_update($remar);

    return $result;
}

/**
 * Removes an instance of the remar from the database
 *
 * Given an ID of an instance of this module,
 * this function will permanently delete the instance
 * and any data that depends on it.
 *
 * @param int $id Id of the module instance
 * @return boolean Success/Failure
 */
function remar_delete_instance($id) {
    global $DB;

    if (! $remar = $DB->get_record('remar', array('id' => $id))) {
        return false;
    }

    // Delete any dependent records here.

    $DB->delete_records('remar', array('id' => $remar->id));

    remar_grade_item_delete($remar);

    return true;
}

/**
 * Returns a small object with summary information about what a
 * user has done with a given particular instance of this module
 * Used for user activity reports.
 *
 * $return->time = the time they did it
 * $return->info = a short text description
 *
 * @param stdClass $course The course record
 * @param stdClass $user The user record
 * @param cm_info|stdClass $mod The course module info object or record
 * @param stdClass $remar The remar instance record
 * @return stdClass|null
 */
function remar_user_outline($course, $user, $mod, $remar) {

    $return = new stdClass();
    $return->time = 0;
    $return->info = '';
    return $return;
}

/**
 * Prints a detailed representation of what a user has done with
 * a given particular instance of this module, for user activity reports.
 *
 * It is supposed to echo directly without returning a value.
 *
 * @param stdClass $course the current course record
 * @param stdClass $user the record of the user we are generating report for
 * @param cm_info $mod course module info
 * @param stdClass $remar the module instance record
 */
function remar_user_complete($course, $user, $mod, $remar) {
}

/**
 * Given a course and a time, this module should find recent activity
 * that has occurred in remar activities and print it out.
 *
 * @param stdClass $course The course record
 * @param bool $viewfullnames Should we display full names
 * @param int $timestart Print activity since this timestamp
 * @return boolean True if anything was printed, otherwise false
 */
function remar_print_recent_activity($course, $viewfullnames, $timestart) {
    return false;
}

/**
 * Prepares the recent activity data
 *
 * This callback function is supposed to populate the passed array with
 * custom activity records. These records are then rendered into HTML via
 * {@link remar_print_recent_mod_activity()}.
 *
 * Returns void, it adds items into $activities and increases $index.
 *
 * @param array $activities sequentially indexed array of objects with added 'cmid' property
 * @param int $index the index in the $activities to use for the next record
 * @param int $timestart append activity since this time
 * @param int $courseid the id of the course we produce the report for
 * @param int $cmid course module id
 * @param int $userid check for a particular user's activity only, defaults to 0 (all users)
 * @param int $groupid check for a particular group's activity only, defaults to 0 (all groups)
 */
function remar_get_recent_mod_activity(&$activities, &$index, $timestart, $courseid, $cmid, $userid=0, $groupid=0) {
}

/**
 * Prints single activity item prepared by {@link remar_get_recent_mod_activity()}
 *
 * @param stdClass $activity activity record with added 'cmid' property
 * @param int $courseid the id of the course we produce the report for
 * @param bool $detail print detailed report
 * @param array $modnames as returned by {@link get_module_types_names()}
 * @param bool $viewfullnames display users' full names
 */
function remar_print_recent_mod_activity($activity, $courseid, $detail, $modnames, $viewfullnames) {
}

/**
 * Function to be run periodically according to the moodle cron
 *
 * This function searches for things that need to be done, such
 * as sending out mail, toggling flags etc ...
 *
 * Note that this has been deprecated in favour of scheduled task API.
 *
 * @return boolean
 */
function remar_cron () {
    return true;
}

/**
 * Returns all other caps used in the module
 *
 * For example, this could be array('moodle/site:accessallgroups') if the
 * module uses that capability.
 *
 * @return array
 */
function remar_get_extra_capabilities() {
    return array();
}

/* Gradebook API */

/**
 * Is a given scale used by the instance of remar?
 *
 * This function returns if a scale is being used by one remar
 * if it has support for grading and scales.
 *
 * @param int $remarid ID of an instance of this module
 * @param int $scaleid ID of the scale
 * @return bool true if the scale is used by the given remar instance
 */
function remar_scale_used($remarid, $scaleid) {
    global $DB;

    if ($scaleid and $DB->record_exists('remar', array('id' => $remarid, 'grade' => -$scaleid))) {
        return true;
    } else {
        return false;
    }
}

/**
 * Checks if scale is being used by any instance of remar.
 *
 * This is used to find out if scale used anywhere.
 *
 * @param int $scaleid ID of the scale
 * @return boolean true if the scale is used by any remar instance
 */
function remar_scale_used_anywhere($scaleid) {
    global $DB;

    if ($scaleid and $DB->record_exists('remar', array('grade' => -$scaleid))) {
        return true;
    } else {
        return false;
    }
}

/**
 * Creates or updates grade item for the given remar instance
 *
 * Needed by {@link grade_update_mod_grades()}.
 *
 * @param stdClass $remar instance object with extra cmidnumber and modname property
 * @param bool $reset reset grades in the gradebook
 * @return void
 */
function remar_grade_item_update($remar, $reset=NULL, $grades=NULL) {
    global $CFG;
    if (!function_exists('grade_update')) { //workaround for buggy PHP versions
        require_once($CFG->libdir.'/gradelib.php');
    }
    
    //return grade_update('mod/remar', $remar->course, 'mod', 'remar', $remar->id, 0, $grades, $params);

    $item = array();
    $item['itemname'] = clean_param($remar->name, PARAM_NOTAGS);
    $item['gradetype'] = GRADE_TYPE_VALUE;

    if ($remar->grade > 0) {
        $item['gradetype'] = GRADE_TYPE_VALUE;
        $item['grademax']  = $remar->grade;
        $item['grademin']  = 0;
    } else if ($remar->grade < 0) {
        $item['gradetype'] = GRADE_TYPE_SCALE;
        $item['scaleid']   = -$remar->grade;
    } else {
        $item['gradetype'] = GRADE_TYPE_NONE;
    }

    if ($reset) {
        $item['reset'] = true;
    }

    grade_update('mod/remar', $remar->course, 'mod', 'remar',
            $remar->id, 0, $grades, $item);
}

/**
 * Delete grade item for given remar instance
 *
 * @param stdClass $remar instance object
 * @return grade_item
 */
function remar_grade_item_delete($remar) {
    global $CFG;
    require_once($CFG->libdir.'/gradelib.php');

    return grade_update('mod/remar', $remar->course, 'mod', 'remar',
            $remar->id, 0, null, array('deleted' => 1));
}

/**
 * Update remar grades in the gradebook
 *
 * Needed by {@link grade_update_mod_grades()}.
 *
 * @param stdClass $remar instance object with extra cmidnumber and modname property
 * @param int $userid update grade of specific user only, 0 means all participants
 */
function remar_update_grades($remar, $userid=0, $nullifnone=true) {
    global $CFG, $DB;
    if (!function_exists('grade_update')) { //workaround for buggy PHP versions
        require_once($CFG->libdir.'/gradelib.php');
    }
    
    // Populate array of grade objects indexed by userid.
    $newgrade = new stdClass();
    $newgrade->userid = $userid;
    
    if ($remar->rawgrade != null) {
        $newgrade->rawgrade = $remar->rawgrade;
    }
    else {
        $newgrade->rawgrade = NULL;
    }

    grade_update('mod/remar', $remar->course, 'mod', 'remar', $remar->id, 0, $newgrade);
}

/* File API */
/**
 * Returns an array of game type objects to construct
 * menu list when adding new game 
 *
 */
function remar_get_types(){
    global $DB;

    $config = get_config('remar');

    $types = array();

    $type = new object();
    $type->modclass = MOD_CLASS_ACTIVITY;
    $type->type = "remar_group_start";
    $type->typestr = '--'.get_string( 'modulename', 'remar');
    $types[] = $type;

    if( isset( $config->game1))
        $hide = ($config->game1 != 0);
    else
        $hide = false;
    if( $hide == false)
    { 
        $type = new object();
        $type->modclass = MOD_CLASS_ACTIVITY;
        $type->type = "remar&amp;type=game1";
        $type->typestr = get_string('game1', 'remar');
        $types[] = $type;
    }

    if( isset( $config->game2))
        $hide = ($config->game2 != 0);
    else
        $hide = false;
    if( $hide == false)
    { 
        $type = new object();
        $type->modclass = MOD_CLASS_ACTIVITY;
        $type->type = "remar&amp;type=game2";
        $type->typestr = get_string('game2', 'remar');
        $types[] = $type;
    }
    
    $type = new object();
    $type->modclass = MOD_CLASS_ACTIVITY;
    $type->type = "remar_group_end";
    $type->typestr = '--';
    $types[] = $type;

    return $types;
}

/**
 * Returns the lists of all browsable file areas within the given module context
 *
 * The file area 'intro' for the activity introduction field is added automatically
 * by {@link file_browser::get_file_info_context_module()}
 *
 * @param stdClass $course
 * @param stdClass $cm
 * @param stdClass $context
 * @return array of [(string)filearea] => (string)description
 */
function remar_get_file_areas($course, $cm, $context) {
    return array();
}

/**
 * File browsing support for remar file areas
 *
 * @package mod_remar
 * @category files
 *
 * @param file_browser $browser
 * @param array $areas
 * @param stdClass $course
 * @param stdClass $cm
 * @param stdClass $context
 * @param string $filearea
 * @param int $itemid
 * @param string $filepath
 * @param string $filename
 * @return file_info instance or null if not found
 */
function remar_get_file_info($browser, $areas, $course, $cm, $context, $filearea, $itemid, $filepath, $filename) {
    return null;
}

/**
 * Serves the files from the remar file areas
 *
 * @package mod_remar
 * @category files
 *
 * @param stdClass $course the course object
 * @param stdClass $cm the course module object
 * @param stdClass $context the remar's context
 * @param string $filearea the name of the file area
 * @param array $args extra arguments (itemid, path)
 * @param bool $forcedownload whether or not force download
 * @param array $options additional options affecting the file serving
 */
function remar_pluginfile($course, $cm, $context, $filearea, array $args, $forcedownload, array $options=array()) {
    global $DB, $CFG;

    if ($context->contextlevel != CONTEXT_MODULE) {
        send_file_not_found();
    }

    require_login($course, true, $cm);

    send_file_not_found();
}

/* Navigation API */

/**
 * Extends the global navigation tree by adding remar nodes if there is a relevant content
 *
 * This can be called by an AJAX request so do not rely on $PAGE as it might not be set up properly.
 *
 * @param navigation_node $navref An object representing the navigation tree node of the remar module instance
 * @param stdClass $course current course record
 * @param stdClass $module current remar instance record
 * @param cm_info $cm course module information
 */
function remar_extend_navigation(navigation_node $navref, stdClass $course, stdClass $module, cm_info $cm) {
    // TODO Delete this function and its docblock, or implement it.
}

/**
 * Extends the settings navigation with the remar settings
 *
 * This function is called when the context for the page is a remar module. This is not called by AJAX
 * so it is safe to rely on the $PAGE.
 *
 * @param settings_navigation $settingsnav complete settings navigation tree
 * @param navigation_node $remar remar administration node
 */
function remar_extend_settings_navigation(settings_navigation $settingsnav, navigation_node $remarnode=null) {
    // TODO Delete this function and its docblock, or implement it.
}
