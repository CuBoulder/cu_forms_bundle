<?php
/**
 * @file
 * cu_webform.features.field_instance.inc
 */

/**
 * Implements hook_field_default_field_instances().
 */
function cu_webform_field_default_field_instances() {
  $field_instances = array();

  // Exported field_instance: 'node-webform-field_add_form_owner'.
  $field_instances['node-webform-field_add_form_owner'] = array(
    'bundle' => 'webform',
    'default_value' => NULL,
    'deleted' => 0,
    'description' => '',
    'display' => array(
      'default' => array(
        'label' => 'above',
        'settings' => array(),
        'type' => 'hidden',
        'weight' => 2,
      ),
      'teaser' => array(
        'label' => 'above',
        'settings' => array(),
        'type' => 'hidden',
        'weight' => 0,
      ),
    ),
    'entity_type' => 'node',
    'fences_wrapper' => 'div_div_div',
    'field_name' => 'field_add_form_owner',
    'label' => 'Add Form Owner',
    'required' => 0,
    'settings' => array(
      'user_register_form' => FALSE,
    ),
    'widget' => array(
      'active' => 1,
      'module' => 'entityreference',
      'settings' => array(
        'match_operator' => 'CONTAINS',
        'path' => '',
        'size' => 60,
      ),
      'type' => 'entityreference_autocomplete',
      'weight' => 33,
    ),
  );

  // Translatables
  // Included for use with string extractors like potx.
  t('Add Form Owner');

  return $field_instances;
}