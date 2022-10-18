# YAML Syntax

## Introduction

YAML is a data serialization language that is often used for writing configuration files. Most DevOps tools have configuration file written in YAML.

Most of the time the extension is `.yml` but you will also find `.yaml` in the wild.

## Syntax

The following code is a YAML file, the comments will explain what is what:

```yml
# This is a comment

# Object
microservice:
  # Standard indentation is 2 spaces
  # Basic key-value pairs
    
    # This is a list
  - app: user-authentication # you can use " or ' or no quotes at all
    # This is an element of the app list. A list can also be composed of only one element
    app-details: "user-registration \n" # If you have special characters you need   quotes
    port: 9000
    env:
      service-name: {{ .Values.service.name }} # placeholder
      mysql-password: $MYSQL_PASSWORD # environment variable
    
    # Boolean, also works with yes/no
    deployed: true
    
    # List inside list
    versions:
    - 1.7
    - 1.9
    - 2.0

    multilineString: |
      This is a multiline string,
      this will be interpreted as a single line
    
    multilineSingleString: >
      This is a multiline string.
      This will be interpreted as multiple lines
```

## Sources

- [TechWorld with Nana](https://www.youtube.com/watch?v=1uFVr15xDGg)
