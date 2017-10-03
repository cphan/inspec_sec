-------------------

#This is an example of security compliance framework for Linux, AIX and Windows servers.

-------------------

##Pre-requisites:
* Need to install latest ChefDK (see https://docs.chef.io/install_dk.html)
* To check if Inspec was installed, try "inspec version"

-------------------

##Usage Examples:

###host file format example:

```text
hostname1 x.x.x.x
hostname2 y.y.y.y
```

###checkComplianceOnHosts.sh usage example

```bash
./checkComplianceOnHosts.sh <host_file>
```
-------------------

## Author: Chris Phan  ([cphan@yahoo.com](mailto:cphan@yahoo.com))

-------------------
