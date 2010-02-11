use strict;
use Template;

my @data = ( 
   {
            'name' => 'Koldo Echavarren ',
            'projects' => {
                            'Gobierno de Navarra - Aplicaciones Comunicaci�n' => [
                                                                                   'GOBIERNO NAVARRA',
                                                                                   'Olatz Zamora',
                                                                                   '0.6'
                                                                                 ],
                            'Project 2' => [ 'foo', 'bar', 'baz'],
                          },
            'id' => 38
   },
   {
            'name' => 'Adriana Ojuel',
            'projects' => {
                            'varios proyectos' => [
                                                    'CAN-JAVA (equipo fijo)',
                                                    'Joserra Diaz',
                                                    '1'
                                                  ]
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
[% FOREACH project_name IN user.projects.keys %]
    Project name:   [% project_name %]
    Project leader: [% user.projects.$project_name.0 %]
    Project client: [% user.projects.$project_name.1 %]
    Project time:   [% user.projects.$project_name.2 %]
[% END -%]
[% END -%]

