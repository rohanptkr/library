[ec2-user@ip-172-31-21-142 ~]$ cat .bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
#
PATH=$PATH:$HOME/bin

export MAVEN_HOME=/mnt/apache-maven-3.9.11
export PATH=$MAVEN_HOME/bin:$PATH

export PATH
