######################
# CuongLM's Rex file #
######################

use v5.14;
use Rex -base;
use Rex::Commands::Run;
use Rex::Commands::File;
use Rex::Commands::Fs;
use File::Basename;
use Try::Tiny;

user "cuonglm";

private_key "/home/cuonglm/.ssh/id_rsa";
public_key "/home/cuonglm/.ssh/id_rsa.pub";

logging to_file => "rex.log";

# uncomment to deploy in many servers
#group servers => "server name here",;

#################
# Function here #
#################
            
sub check_user {
    
    my ($user) = @_;
    run "id -u $user";
    
    if ( $? == 0 ) {
        return $user;
    }
}

sub add_sudoer {
    
    sudo -on;
    my $user = $_[0];
    my $entry = $_[1];
    my $fh;

    eval {
        $fh = file_append("/etc/sudoers");
    };

    if ($@) {
        say "Can't open /etc/sudoers file:$@";
        exit;
    }

    eval { $fh->write($entry); };

    if ($@) {
        say "Add $user to sudoers Failed.";
    } else {
        say "Add $user to sudoers OK!";
    }
    
    $fh->close;
    exit 0;
}

#############
# Task here #
#############

# Get uptime

desc "Get uptime of servers";

task uptime => sub {
    
    say run 'echo $HOSTNAME';
    say run 'uptime';

};

# Creat new user

desc "Creat new user, add public key, and add to sudoer if necessary";

task adduser => sub {
    
    my ($param) = @_;
    die "No such username given, please use [--user]"
        unless exists $param->{user};

    my $user = $param->{user};
    my $sudoer = $param->{sudoer};
    my @pass = map { ( "a".."z","A".."Z","0".."9" )[rand 62] } 1..20; 
    my $pass = join('', @pass); 
    my $shell = "/bin/bash";
    my $bashrc = "/etc/skel/.bashrc";
    my $sudo_add = $user . '        ALL=(ALL:ALL) NOPASSWD:ALL'; 

    my $cmd_add = 'sudo useradd -m -s ' . "$shell" . ' ' . "$user";
    my $cmd_cp = 'sudo install -o ' . "$user " . '-g ' . "$user " . "$bashrc " . '~' . "$user";
    my $cmd_pass = 'sudo echo -e ' . '"' . $pass . '\n' . $pass . '"' . ' | sudo passwd ' . "$user";
    #my $cmd_sudo = 'sudo echo "' . $sudo_add . '" >> /etc/sudoers';

    # Check user existed
    if ( check_user($user) ) {

        say "$user existed!!!";
        exit;
    }

    # Creat User
    run $cmd_add;

    if ( $? != 0 ) {
        die "Can't creat $user.";
    } else {
        say "Creat user $user OK!";
    }
    
    # Creat ".bashrc file"
    run $cmd_cp;

    if ( $? != 0 ) {
        die "Can't copy .bashrc file.";
    } else {
        say 'Copy file "' . $bashrc . '" OK!';
    }

    # Creat password
    run $cmd_pass;

    if ( $? != 0 ) {
        die "Can't creat $user\'s password.";
    } else {
        say "Creat $user\'s password OK!";
    }

    # Add to sudoers
 
    # Method 1, run fast, uncomment $cmd_sudo to use 
    #sudo $cmd_sudo;

    #if ( $? !=0 ) {
    #    die "Can't add $user to sudoers.";
    #} else {
    #    say "Add $user to sudoers OK!";
    #}

    # Method 2, run slow

    if ( $sudoer eq 'YES' ) {
    
        add_sudoer($user, $sudo_add);
    
    } 
};
