# Quick draft of using XML::Twig + Graphviz to visualize some ne.gov data
#    by jay.hannah@iinteractive.com 
#    Repo: https://github.com/jhannah/sandbox/tree/master/ne.gov

use 5.12.1;
use XML::Twig;
use GraphViz2;

my $graphviz = GraphViz2->new(
   graph => { rankdir => 'LR' },   # left to right
);
my $known_edges = {};

my $dir = '/Users/jhannah/src/gist-5287892';
# ------------------------------------------
my $file = "$dir/serverServicemap.xml";
say "Parsing $file...";
my $twig = XML::Twig->new(
   twig_handlers => {
      Service => \&process_service,
   },
);
$twig->parsefile($file);
my $root = $twig->root;
# ------------------------------------------
my $file = "$dir/serverQueuemap.xml";
say "Parsing $file...";
my $twig = XML::Twig->new(
   twig_handlers => {
      workerQueue => \&process_worker_queue,
   },
);
$twig->parsefile($file);
my $root = $twig->root;
# ------------------------------------------
$file = "map.png";
say "Writing $file...";
$graphviz->run(
   format      => 'png',
   output_file => $file,
) or die $!;

exit;
# ----------------
#  END MAIN
# ----------------

sub process_service {
   my ($twig, $s) = @_;
   return unless ($s->first_child('Action')->first_child('QueueId'));
   my $name =            $s->first_child('Name')->text;
   my $action_name =     $s->first_child('Action')->first_child('Name')->text;
   my $action_queue_id = $s->first_child('Action')->first_child('QueueId')->text;
   add_edge($name, $action_queue_id);
}


sub process_worker_queue {
   my ($twig, $wq) = @_;
   my $q =     $wq->first_child('queueId')->text;
   my $db =    $wq->first_child('databaseId')->text;
   my $table = $wq->first_child('tableName')->text;
   add_edge($q, $db);
   add_edge($db, $table);
}


=head2 add_edge

So here we define our own add_edge() because as programs like this grow we often
end up wanting to customize our calls to GraphViz2 without repeating ourselves a dozen
times in our source. GraphViz2 lets you change ovals to boxes under certain conditions,
add labels to arrows, change colors, line types, arrow types, etc, etc...

=cut

sub add_edge {
   my ($x, $y, %args) = @_;
   say "   $x -> $y";
   $graphviz->add_edge(from => $x, to => $y, dir => 'forward', %args);

   # Sometimes we want to de-dupe known edges. If so, we'd use this:
   $known_edges->{$x}->{$y} = 1;
}



