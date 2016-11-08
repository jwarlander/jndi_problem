set +x
export KETTLE_HOME=$HOME/jndi_problem/config
export KETTLE_JNDI_ROOT=/$HOME/jndi_problem/jndi
cd $HOME/pentaho6/data-integration
./carte.sh $KETTLE_HOME/carte.xml
