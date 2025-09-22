package Plugins::DSPFIRMellow::Settings;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;
use Slim::Web::Pages;
use Slim::Web::HTTP;

my $log = logger('plugin.dspfirmellow');
my $prefs = preferences('plugin.dspfirmellow');

sub new {
    my ($class) = @_;
    
    $log->info("Loading DSPFIRMellow Settings");
    
    eval {
        Slim::Web::Pages->addPageFunction(
            'plugins/DSP-FIR-Mellow/settings/basic.html',
            \&basicSettings
        );
    };
    
    if ($@) {
        $log->error("Failed to add web page: $@");
    }
    
    return $class;
}

sub basicSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('enabled', $params->{enabled} ? 1 : 0);
        $prefs->set('pcm_sample_rate', $params->{pcm_sample_rate} || '768000');
        $prefs->set('pcm_bit_depth', $params->{pcm_bit_depth} || '32');
        $prefs->set('pcm_dither', $params->{pcm_dither} || 'e_weighted');
    }
    
    $params->{enabled} = $prefs->get('enabled');
    $params->{pcm_sample_rate} = $prefs->get('pcm_sample_rate');
    $params->{pcm_bit_depth} = $prefs->get('pcm_bit_depth');
    $params->{pcm_dither} = $prefs->get('pcm_dither');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/DSP-FIR-Mellow/settings/basic.html',
        $params
    );
}

1;
