# The Problem

When having more than one table input / output step in a transformation, and
running it using Carte or Pan instead of through Spoon, the JNDI connections will
apparently get mixed up, and be assigned to the wrong steps. This can be
anything from annoying but benign (when the involved databases have entirely
different schemas), to completely disastrous (if the same table exists in both
databases, but should get read from one and written to the other as part of eg.
a data migration flow).

This repository depends on there being a PostgreSQL instance running, where a
user `johwar` owns two different databases, `test1` and `test2`. It contains
three transformations:

- test_jndi_test1.ktr _(takes data from `test1` and a data grid)_
- test_jndi_test1.ktr _(takes data from `test2` and a data grid)_
- test_jndi_both.ktr _(takes data from both `test1` and `test2`)_

All of the transformations do the same thing - read a series of integers from
one source, and a series of strings from the other, then does a cross join and
writes the result to the log.

In each of the first two cases, things run fine; `test_jndi_test1.ktr` is with
the integers from `test1` and the strings from a data grid, while
`test_jndi_test2.ktr` takes the integers from a data grid and the strings from
`test2`.

The third one, `test_jndi_both.ktr`, uses both the databases at once, and has no
data grid. It's the problematic one, and will sometimes / usually / always fail
with an error message indicating it can't find the referred table (since the
table input steps seem to be getting handed the wrong connection).

_NOTE: This issue seems to happen in Carte as well, but less frequently (maybe
every 2-5 attempts or something), and taht's how we originally noticed it.. I've
updated the repository with additional scripts and instructions, in order to
facilitate testing in Carte as well._

# Setting up

- clone this repository into `$HOME/jndi_problem`
- make sure PostgreSQL is installed
- run db setup script:

        ./db_setup.sh

# Running tests

- make sure PDI is installed
- edit `test_jndi_*.sh` and adjust location of PDI as needed
- run the scripts:

        ./test_jndi_test1.sh
        ./test_jndi_test2.sh
        ./test_jndi_both.sh

# Testing in Carte

First, start a Carte instance:

    ./run_carte.sh

Then, in another terminal, submit the `test_jndi_both` transformation a few
times; you should see it both fail and succeed, when observice the Carte output:

    ./test_jndi_both_carte.sh
