<?php
defined('MOODLE_INTERNAL') || die();

$THEME->name        = 'tintagel';
$THEME->sheets      = [];
$THEME->editor_sheets = [];
$THEME->parents     = ['boost'];
$THEME->enable_dock = false;
$THEME->yuicssmodules = [];
$THEME->rendererfactory = 'theme_overridden_renderer_factory';
$THEME->scss        = function($theme) {
    return theme_tintagel_get_main_scss_content($theme);
};
$THEME->layouts = (new theme_config('boost'))->layouts;
