use strict;
use Template;

my @data = ( 
   {
            'name' => 'Person1',
            'projects' => {
                            'Aplicaciones Comunicaci�n' => {
                                         leader => 'leader 1',
                                         client => 'client 1',
                                         time   =>  '0.6',
                            }, 
                            'Project 2' =>  {
                                         leader => 'foo', 
                                         client => 'bar', 
                                         time   => 'baz',
                            }
                        },
            'id' => 38
   },
   {
            'name' => 'person2',
            'projects' => {
                            'varios proyectos' => {
                                         leader => 'CAN-JAVA (equipo fijo)',
                                         client => 'Client 2',
                                         time   => '1'
                            },
                          },
            'id' => 0
   }
);


my $vars = {
    data    => \@data,
};
my $tt = Template->new;
$tt->process(\*DATA, $vars) || die $tt->error();

__DATA__
[%  FOREACH user IN data -%]
User ID:   [% user.id %]
User name: [% user.name %]
User work:
[% FOREACH project_name IN user.projects.keys;
      project = user.projects.$project_name; %]
    Project name:   [% project_name %]
    Project leader: [% project.leader %]
    Project client: [% project.client %]
    Project time:   [% project.time %]
[% END -%]
[% END -%]

