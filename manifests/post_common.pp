class post_common (
  $aem_servlet_trigger_address  = 'author-example.com/process.svgiconprocess.svg',
  $aem_servlet_status_address   = 'author-example/process.iconprocessstatus.svg',
  $aem_user                     = 'orchestrator',
  $aem_password                 = $::aem_password,

)
{


  wait_for { 'triggers the processing job':
    query => "curl -IkL  -u orchestrator:$aem_password $aem_servlet_trigger_address -X GET",
    regex => 'HTTP/1.1 200 OK',
  }

  wait_for { 'determine whether it has completed':
    query => "curl -IkL  -u orchestrator:$aem_password $aem_servlet_status_address -X GET",
    regex => 'HTTP/1.1 200 OK',
  }
}


include post_common
