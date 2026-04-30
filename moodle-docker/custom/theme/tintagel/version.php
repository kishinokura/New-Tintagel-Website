<?php
defined('MOODLE_INTERNAL') || die();

$plugin->component = 'theme_tintagel';
$plugin->version   = 2026042900;
$plugin->release   = '0.1.0';
$plugin->requires  = 2022112800; // Moodle 4.1+
$plugin->maturity  = MATURITY_ALPHA;
$plugin->dependencies = ['theme_boost' => ANY_VERSION];
