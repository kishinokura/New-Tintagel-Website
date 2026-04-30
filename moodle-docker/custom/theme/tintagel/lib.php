<?php
defined('MOODLE_INTERNAL') || die();

function theme_tintagel_get_main_scss_content($theme) {
    global $CFG;
    $boost = file_get_contents($CFG->dirroot . '/theme/boost/scss/preset/default.scss');
    $pre   = file_get_contents(__DIR__ . '/scss/pre.scss');
    $post  = file_get_contents(__DIR__ . '/scss/post.scss');
    return $pre . "\n" . $boost . "\n" . $post;
}
