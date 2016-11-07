set +x
export KETTLE_HOME=$HOME/jndi_problem/config
export KETTLE_JNDI_ROOT=/$HOME/jndi_problem/jndi
cd $HOME/pentaho6/data-integration
./pan.sh -file $HOME/jndi_problem/test_jndi_both.ktr
