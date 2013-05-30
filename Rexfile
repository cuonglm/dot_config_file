######################
# CuongLM's Rex file #
######################

use v5.14;
use Rex -base;
use Rex::Commands::Run;
use Rex::Commands::File;
use Rex::Commands::Fs;
use Rex::Commands::Process;
use Rex::Commands::Gather;
use Data::Dumper;
use File::Basename;

user "cuonglm";

private_key "/home/cuonglm/.ssh/id_rsa";
public_key "/home/cuonglm/.ssh/id_rsa.pub";

logging to_file => "rex.log";

# uncomment to deploy in many servers
#group servers => "server name here",;

#################
# Constant here #
#################

# Public key file
my $pub_key_file = "/home/cuonglm/PublicKeys";

open my ($fh) , '<', $pub_key_file
    or die "Can not open $pub_key_file: $!";

my %key_dict;

while (<$fh>) {
	                
    my ($user, $pubkey) = split /\s/, $_, 2;
    $key_dict{$user} = $pubkey;

}

#################
# Function here #
#################
            
sub check_user {
    
    my ($user) = @_;
    run "id -u $$user";
    
    if ( $? == 0 ) {
        return $$user;
    }
}

sub add_sudoer {
    
    sudo -on;
    my ($user) = $_[0];
    my ($entry) = $_[1];
    my $fh;

    eval {
        $fh = file_append("/etc/sudoers");
    };

    if ($@) {
        say "Can't open /etc/sudoers file:$@";
        exit;
    }

    eval { 
	    
        $fh->write($$entry); 
        $fh->write("\n"); 
    
    };

    if ($@) {
        say "Add $$user to sudoers Failed.";
    } else {
        say "Add $$user to sudoers OK!";
    }
    
    $fh->close;
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

    # Check user existed
    if ( check_user(\$user) ) {

        say "$user existed!!!";
        exit;
    }

    # Creat User
    my $shell = "/bin/bash";

    my $cmd_add = 'sudo useradd -m -s ' . "$shell" . ' ' . "$user";

    run $cmd_add;

    if ( $? != 0 ) {
        die "Can't creat $user.";
    } else {
        say "Creat user $user OK!";
    }
    
    # Creat ".bashrc file"

    my $bashrc = "/etc/skel/.bashrc";

    my $cmd_cp = 'sudo install -o ' . "$user " . '-g ' . "$user " . "$bashrc " . '~' . "$user";

    run $cmd_cp;

    if ( $? != 0 ) {
        die "Can't copy .bashrc file.";
    } else {
        say 'Copy file "' . $bashrc . '" OK!';
    }

    # Creat password
    my @pass = map { ( "a".."z","A".."Z","0".."9" )[rand 62] } 1..20; 

    my $pass = join('', @pass); 

    my $cmd_pass = 'sudo echo -e ' . '"' . $pass . '\n' . $pass . '"' . ' | sudo passwd ' . "$user";

    run $cmd_pass;

    if ( $? != 0 ) {
        die "Can't creat $user\'s password.";
    } else {
        say "Creat $user\'s password OK!";
    }

    # Add to sudoers
    my $sudo_add = $user . '        ALL=(ALL:ALL) NOPASSWD:ALL'; 
 
    # Method 1, run fast, uncomment $cmd_sudo to use 
    #my $cmd_sudo = 'sudo echo "' . $sudo_add . '" >> /etc/sudoers';

    #sudo $cmd_sudo;

    #if ( $? !=0 ) {
    #    die "Can't add $user to sudoers.";
    #} else {
    #    say "Add $user to sudoers OK!";
    #}

    # Method 2, run slow

    if ( lc($sudoer) eq 'yes' ) {
    
        add_sudoer(\$user, \$sudo_add);
    
    } 

    # Add Public key
    my $auth_file = '/home/' . $user . '/.ssh/authorized_keys';

    my $dot_ssh = '/home/' . $user . '/.ssh';

    my $cmd_make_dir = 'mkdir -p ' . $dot_ssh;

    sudo $cmd_make_dir;
    
    my $cmd_make_auth_file = 'touch ' . $auth_file;

    my $cmd_write_auth_file = "";

    if ( exists $key_dict{$user} ) {

        $cmd_write_auth_file = 'echo "' . "$user" . ' ' . $key_dict{$user} . '" >> ' . "$auth_file";

        if ( ! -e $auth_file ) {

            sudo $cmd_make_auth_file;

        } 

        open my ($fh), '<', $auth_file
            or die "Can not open $auth_file: $!";

        my @inputs = <$fh>;

            if ( grep /$user/, @inputs ) {

                say "$user\'s existed!";

                close ($fh);

            } else {

                sudo $cmd_write_auth_file;

                if ($? != 0 ) {

                    die "Can't add public key.";

                } else {

                    say "Add public key OK!";

                } 

            }

    } else {

        say "Can't find $user\'s key, Please place it in $auth_file!";

    }

};

# Get Memory Information

desc "Get Memory Information";

task "getmemory" => sub {
	
    my $mem = memory();

    say run 'echo $HOSTNAME';
    say "Mem Total   : 	" . $mem->{total};
    say "Mem Free    : 	" . $mem->{free};
    say "Mem Used    : 	" . $mem->{used};
    say "Mem Cached  : 	" . $mem->{cached};
    say "Mem Buffers : 	" . $mem->{buffers};
    say "";
};
