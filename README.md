Gozma18
=======

Easily vagrant up ubuntu/bionic64 machines.


Included Software
-----------------

- Ubuntu 18.04
- Git
- PHP 7.2
- Apache
- MySQL
- Sqlite3
- PostgreSQL
- Composer
- Node (With Yarn, Bower, Grunt, and Gulp)
- MailHog
- mhsendmail
- Oh My ZSH!


Accessing Globally
------------------

Sometimes you may want to `vagrant up` your Gozma18 machine from anywhere on your filesystem. You can do this on Mac / Linux systems by adding a Bash function to your Bash profile. Here goes a nice sample:

```bash
gozma18() {
  if [ "destroy" == $1 ];
  then
    echo "Sorry, the '$1' command is not encouraged!"
    return 1
  fi

  ( cd /opt/vagrant-local/gozma18 && vagrant $* )
}
```

Make sure to tweak the `/opt/vagrant-local/gozma18` path in the function to the location of your actual Gozma18 installation. Once the function is installed, you may run commands like `gozma18 up` or `gozma18 ssh` from anywhere on your system.


The Hosts File
--------------

You must add the "domains" for your sites to the `hosts` file on your machine. The `hosts` file will redirect requests for your sites into your Gozma18 machine. On Mac and Linux, this file is located at `/etc/hosts`. The lines you add to this file will look like the following:

~~~
192.168.27.14 gozma18.local
~~~
