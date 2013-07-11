######################
# CuongLM's Rex file #
######################

use v5.14;
use Rex -base;
use Rex::Commands::Run;
use Rex::Commands::File;
use Rex::FS::File;
use Rex::Commands::Gather;

user "cuonglm";

private_key "/home/cuonglm/.ssh/id_rsa";
public_key "/home/cuonglm/.ssh/id_rsa.pub";

logging to_file => "rex.log";

# Read servers from hosts file
my @servers = qw();

my $host = file_read "rexhosts";

foreach $| ($host->read_all) {
    $| =~ s/(?:\t|\s)//;
    push @servers, $|;
} 

$host->close;

group hosts => @servers;

#################
# Constant here #
#################

# Public key file
my $pub_key_file = qq(/home/cuonglm/PublicKeys);

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
    } 
    else {
        say "Add $$user to sudoers OK!";
    }
}

#############
# Task here #
#############

# ========== #
# Get uptime #
# ========== #

desc "Get uptime of servers";

task "uptime" => sub {
    
    say run 'echo $HOSTNAME';
    say run 'uptime'; 

};

# ============== #
# Creat new user #
# ============== #

desc "Creat new user, add public key, and add to sudoer if necessary";

task "adduser" => sub {
    
    my ($param) = @_;
    die "No such username given, please use [--user]"
        unless exists $param->{user};

    my $user   = $param->{user};
    my $sudoer = $param->{sudoer};

    # Check user existed
    if ( check_user(\$user) ) {
        say "$user existed!!!";
        
        my $sudo_entry = $user . q(        ALL=(ALL:ALL) NOPASSWD:ALL);

        if ( lc($sudoer) eq 'yes' ) {
            add_sudoer(\$user, \$sudo_entry);
        }
        exit;
    }

    # Creat User
    my $shell = "/bin/bash";

    my $cmd_add =  q(useradd -m -s )
                 . qq($shell) 
                 . q( ) 
                 . qq($user);

    sudo $cmd_add;

    if ( $? != 0 ) {
        die "Can't creat $user.";
    } 
    else {
        say "Creat user $user OK!";
    }
    
    # Creat ".bashrc file"
    my $bashrc = "/etc/skel/.bashrc";

    my $cmd_cp =  q(install -o )
                . qq($user ) 
                . q(-g ) 
                . qq($user ) 
                . qq($bashrc ) 
                . q(~) 
                . qq($user);

    if ( $? != 0 ) {
        die "Can't copy .bashrc file.";
    } 
    else {
        say 'Copy file "' . $bashrc . '" OK!';
    }

    # Creat password
    my @pass = map { ( "a".."z","A".."Z","0".."9" )[rand 62] } 1..20; 

    my $pass = join('', @pass); 

    my $cmd_pass =  q(sudo echo -e )
                  . q(")
                  . qq($pass)
                  . q(\n)
                  . qq($pass)
                  . q(")
                  . q( | sudo passwd )
                  . qq($user);

    run $cmd_pass;

    if ( $? != 0 ) {
        die "Can't creat $user\'s password.";
    } 
    else {
        say "Creat $user\'s password OK!";
    }

    # Add to sudoers
    my $sudo_entry = $user . q(        ALL=(ALL:ALL) NOPASSWD:ALL); 
 
    if ( lc($sudoer) eq 'yes' ) {
        add_sudoer(\$user, \$sudo_entry);
    } 

    # Add Public key
    my $auth_file =  q(/home/)
                   . qq($user)
                   . q(/.ssh/authorized_keys);

    my $dot_ssh =  q(/home/)
                 . qq($user)
                 . q(/.ssh);

    my $cmd_make_dir = q(mkdir -p ) . $dot_ssh;

    sudo $cmd_make_dir;
    
    my $cmd_make_auth_file = q(touch ) . $auth_file;

    my $cmd_write_auth_file = q();

    if ( exists $key_dict{$user} ) {

        $cmd_write_auth_file =  q(echo ")
                              . qq($user)
                              . q( )
                              . $key_dict{$user}
                              . q(" >> )
                              . qq($auth_file);

        if ( ! -e $auth_file ) {
            sudo $cmd_make_auth_file;
        } 


        sudo "open my ($fh), '<', $auth_file"
            or die "Can not open $auth_file: $!";

        my @inputs = <$fh>;
        
        if ( grep /$user/, @inputs ) {
            say "$user\'s existed!";
            close ($fh);
        } 
        else {
            sudo $cmd_write_auth_file;

            if ($? != 0 ) {
                die "Can't add public key.";
            }
            else {
                say "Add public key OK!";
            } 
        }
    } 
    else {
        say "Can't find $user\'s public key, Please place it in $auth_file!";
    }
};

# ====================== #
# Get Memory Information #
# ====================== #

desc "Get Memory Information";

task "getmemory" => sub {
    
    my $mem = memory();

    say run 'echo $HOSTNAME';
    say "Mem Total   :  " . $mem->{total};
    say "Mem Free    :  " . $mem->{free};
    say "Mem Used    :  " . $mem->{used};
    say "Mem Cached  :  " . $mem->{cached};
    say "Mem Buffers :  " . $mem->{buffers};
    say "";

};

desc "Download remote file to local";

task "download" => sub {
    
    my ($params) = @_;

    die "Please chose remote file" unless exists $params->{remote};
    die "Please chose local file" unless exists $params->{local};
    
    my $remote = $params->{remote};
    my $local = $params->{local};
    
    download "$remote", "$local";
        
};
# vim: syntax=perl
# vim: ft=perl
