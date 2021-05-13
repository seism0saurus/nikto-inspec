# Nikto inspec profile

This is a custom inspec [inspec](https://www.inspec.io/) from Ulrich Viefhaus. This is neither an official product of Chef InSpec nor Nikto.

The profile test an http/https server with the open source web server scanner [nikto2](https://cirt.net/Nikto2). 

Nikto checks for known insecure files on the webserver, outdated software versions and insecure configuration items.

You can customoze the profile with attribute files and set hosts, ports and commandline options.

## Preperations

### Inspec

You need access to the inspec command on your testmachine. If you don't have inspec installed, follow the instructions here: https://www.inspec.io/downloads/

### Access to the Docker Demon

You need access to the docker deamon on your testmachine. If you don't have docker installed, follow the instructions here: https://docs.docker.com/install/. Please see the Docker documentation on how to 

### Download the Nikto Docker image

before you can run the nikto profile you have to build the nikto docker image. To build it run

```bash
git clone https://github.com/sullo/nikto
cd nikto
docker build -t sullo/nikto .
```

This repository is linked on the official nikto homepage. There are a lot of nikto images on the docker hub. 

If you trust one of them and want to use it instead the sullo/nikto image, change it in the example[inputs.example.yml](inputs.example.yml) or create a custom attributes file.

## Running the Profile

You can define as many hosts and urls as you want. As a best practice, copy and rename the `inputs.example.yml` to `your-updated-inputs.yml` for your environment, organization or system.

After you have configured your services go into the folder you have downloaded nikto-spec and run

```bash
inspec exec . --input-file <your-updated-inputs.yml>
```

### Passing Options to Nikto

Options you can pass to nikto can be found under https://cirt.net/nikto2-docs/options.html
