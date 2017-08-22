# docker-varnish
Debian 8, Varnish 5.1


## Varnishd Usage

```
varnishd -F -a :80 -T :6082 -f /etc/varnish/default.vcl -s malloc,256m
```

```
Usage: varnishd [options]

Basic options:
  -a address[:port][,proto]    # HTTP listen address and port
                               # Can be specified multiple times.
                               #   default: ":80,HTTP/1"
  -b address[:port]            # Backend address and port
                               #   default: ":80"
  -f vclfile                   # VCL program
                               # Can be specified multiple times.
  -n dir                       # Working directory

-b can be used only once, and not together with -f

Documentation options:
  -?                           # Prints this usage message
  -x parameter                 # Parameter documentation
  -x vsl                       # VSL record documentation
  -x cli                       # CLI command documentation
  -x builtin                   # Builtin VCL program

Operations options:
  -F                           # Run in foreground
  -T address[:port]            # CLI address
                               # Can be specified multiple times.
  -M address:port              # Reverse CLI destination
                               # Can be specified multiple times.
  -P file                      # PID file
  -i identity                  # Identity of varnish instance
  -I clifile                   # Initialization CLI commands

Tuning options:
  -t TTL                       # Default TTL
  -p param=value               # set parameter
                               # Can be specified multiple times.
  -s [name=]kind[,options]     # Storage specification
                               # Can be specified multiple times.
                               #   -s malloc
                               #   -s file
  -l vsl[,vsm]                 # Size of shared memory file
                               #   vsl: space for VSL records [80m]
                               #   vsm: space for stats counters [1m]

Security options:
  -r param[,param...]          # Set parameters read-only from CLI
                               # Can be specified multiple times.
  -S secret-file               # Secret file for CLI authentication
  -j jail[,options]            # Jail specification
                               #   -j unix
                               #   -j none

Advanced/Dev/Debug options:
  -d                           # debug mode
                               # Stay in forground, CLI on stdin.
  -C                           # Output VCL code compiled to C language
  -V                           # version
  -h kind[,options]            # Hash specification
  -W waiter                    # Waiter implementation
```

## Varnishd default config

```
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}
```

