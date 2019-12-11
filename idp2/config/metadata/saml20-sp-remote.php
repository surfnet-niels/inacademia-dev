<?php
/**
 * SAML 2.0 remote SP metadata for SimpleSAMLphp.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote
 */

$metadata['https://inacademia.local/metadata/inacademia-simple-validation.xml'] = array (
  'entityid' => 'https://inacademia.local/metadata/inacademia-simple-validation.xml',
  'description' => 
  array (
  ),
  'OrganizationName' => 
  array (
    'en' => 'InAcademia',
  ),
  'name' => 
  array (
    'en' => 'InAcademia Affiliation Validation Service',
  ),
  'OrganizationDisplayName' => 
  array (
    'en' => 'InAcademia',
  ),
  'url' => 
  array (
    'en' => 'https://inacademia.org/about',
  ),
  'OrganizationURL' => 
  array (
    'en' => 'https://inacademia.org/about',
  ),
  'contacts' => 
  array (
    0 => 
    array (
      'contactType' => 'support',
      'givenName' => 'InAcademia',
      'surName' => 'Enduser Support',
      'emailAddress' => 
      array (
        0 => 'help@inacademia.org',
      ),
    ),
    1 => 
    array (
      'contactType' => 'technical',
      'givenName' => 'InAcademia',
      'surName' => 'Administrative Support',
      'emailAddress' => 
      array (
        0 => 'admin@inacademia.org',
      ),
    ),
    2 => 
    array (
      'contactType' => 'technical',
      'givenName' => 'InAcademia',
      'surName' => 'Technical Support',
      'emailAddress' => 
      array (
        0 => 'tech@inacademia.org',
      ),
    ),
  ),
  'metadata-set' => 'saml20-sp-remote',
  'AssertionConsumerService' => 
  array (
    0 => 
    array (
      'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
      'Location' => 'https://op.inacademia.local/InAcademiaBackend/acs/post',
      'index' => 1,
    ),
  ),
  'SingleLogoutService' => 
  array (
  ),
  'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
  'attributes.required' => 
  array (
    0 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.9',
  ),
  'attributes.NameFormat' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
  'keys' => 
  array (
    0 => 
    array (
      'encryption' => false,
      'signing' => true,
      'type' => 'X509Certificate',
      'X509Certificate' => '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
',
    ),
  ),
  'validate.authnrequest' => false,
  'saml20.sign.assertion' => true,
  'UIInfo' => 
  array (
    'DisplayName' => 
    array (
      'en' => 'InAcademia Affiliation Validation Service',
    ),
    'Description' => 
    array (
      'en' => 'InAcademia validates the affiliation status (student, faculty, staff) assigned to you by your home institution. This data then is provided in anonymized form to services which for example grant student discounts. While your Institution assists in validation your affiliation, it has no relation with the Service requesting to validate your affiliation.',
    ),
    'InformationURL' => 
    array (
      'en' => 'https://inacademia.org/about',
    ),
    'PrivacyStatementURL' => 
    array (
      'en' => 'https://inacademia.org/about/privacy',
    ),
    'Keywords' => 
    array (
      'en' => 
      array (
        0 => 'Affiliation',
        1 => 'Validation',
        2 => 'Eligibility',
      ),
    ),
    'Logo' => 
    array (
      0 => 
      array (
        'url' => 'https://inacademia.org/static/logo.png',
        'height' => 60,
        'width' => 120,
        'lang' => 'en',
      ),
    ),
  ),
);

