# This class can be used install rundeck components.
#
# @example when declaring the rundeck class
#  class { '::profiles::orchestration::rundeck': }
#
# @param auth_config       Authentication config.
# @param auth_types        The method(s) used to authenticate to rundeck.
# @param grails_server_url External url.
# @param jvm_args          Additional rundeck jvm arguments.
# @param manage_repo       Manage rpm repository.
# @param package           Package to install.
# @param projects          Projects to manage
# @param puppetdb          Install puppetdb plugin
# @param puppetdb_version  What version to install.
class profiles::orchestration::rundeck (
  Hash $auth_config         = {
    'file' => {
      'admin_user'     => 'admin',
      'admin_password' => 'secret',
      'auth_users'     => {},
      'file'           => '/etc/rundeck/realm.properties',
    },
  },
  Array $auth_types         = ['file'],
  String $grails_server_url = "http://${::fqdn}",
  String $jvm_args          = '-Dserver.http.host=127.0.0.1',
  Boolean $manage_repo      = false,
  String $package           = '2.9.3',
  Hash $projects            = {},
  Boolean $puppetdb         = false,
  String $puppetdb_version  = '0.9.5',
) {
  class { '::rundeck':
    auth_config       => $auth_config,
    auth_types        => $auth_types,
    grails_server_url => $grails_server_url,
    jvm_args          => $jvm_args,
    manage_repo       => $manage_repo,
    package_ensure    => $package,
  }
  create_resources(rundeck::config::project, $projects)

  if $puppetdb {
    class { 'profiles::orchestration::rundeck::puppetdb':
      version => $puppetdb_version,
    }
  }
}
