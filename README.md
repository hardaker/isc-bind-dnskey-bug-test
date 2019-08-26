# BIND DNSKEY-query bug test suite

This package contains the tools used that found a bug in bind where
the number of DNSKEY queries was suddenly obsessive in certain
situations.

See the longer write up on my [ISI
news](https://www.isi.edu/~hardaker/news/20190404-bind-bug.html) site.

# Usage

To run the tests, first edit `dns.test.sh` and then run `run-tests`:

    # ./run-tests

This:

* **must be run on an otherwise unused machine/VM**
* **will kill any running tcpdump processes**
* **will kill any running instances of bind/named**

# Outputs
