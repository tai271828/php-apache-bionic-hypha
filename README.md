# Fetch Souce

```bash
git clone git@github.com:tai271828/php-apache-bionic-hypha.git --recurse-submodules -j4
```

# Building

To build:

```bash
docker build -t tai271828/hypha:bionic .
```

```bash
docker build --no-cache -t tai271828/hypha:bionic .
```

# Running

```bash
docker run -it -p 80:80 --name hypha-instance tai271828/hypha:bionic
```

# House Cleaning

```bash
docker rm hypha-instance
docker image rm tai271828/hypha:bionic
```
