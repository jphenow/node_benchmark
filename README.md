# YABP or Yet Another Benchmark Project

This is another benchmark project setup to test:

* Node.js
* Ruby EventMachine
* Twisted Python
* PHP/Apache (I know hardly comparable in this group, pure interest)

## There'll be no hand-holding here

Sorry I just don't have the time to setup a dependcy check on this all, especially
since I've already got all of these set up on my Mac and Linux Mint computers. On
any *nix computer their setups should be pretty straight-forward.

I basically supply the basic scripts for you to run `ab [thing]` on. So you'll need
get to each directory and run the server. For PHP you'll want to put them in an Apache
accessible directory with PHP module enabled.

Be sure to run a `bundle install` in the top directory to get Ruby dependencies.

*This may change. I hope to implement a good way to swap these each and run each of them
to get results*

## You need

* Ruby 1.9.2+
* Python 2.7 and Twisted
* Node.js v0.6.7+
* PHP 5.3.8
* Apache
* MySQL

You'll also want to set the environment variables accordingly:

* `BENCHMARK_HOST`
* `BENCHMARK_USER`
* `BENCHMARK_PASS`
* `BENCHMARK_DB`
* `BENCHMARK_PORT`

**I didn't have time to switch to using this method for PHP so the php/io_world/db.php must be filled in**

## Things you might want

It might be more "fair" to ensure that the Database you connect to is running on a
separate computer. If you do so, be sure to check that the server or script follows
your change accordingly.
