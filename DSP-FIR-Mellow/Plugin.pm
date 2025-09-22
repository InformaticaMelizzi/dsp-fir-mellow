package Plugins::DSPFIRMellow::Plugin;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;

my $log = logger('plugin.dspfirmellow');
my $prefs = preferences('plugin.dspfirmellow');

sub initPlugin {
    my ($class) = @_;
    
    $log->info("DSP-FIR-Mellow plugin v1.0.0 initialized");
    
    # Load settings modules
    eval {
        require Plugins::DSPFIRMellow::Settings;
        Plugins::DSPFIRMellow::Settings->new();
    };
    
    if ($@) {
        $log->error("Failed to load settings: $@");
        return 0;
    }
    
    return 1;
}

1;
