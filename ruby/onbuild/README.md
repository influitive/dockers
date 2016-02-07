# Ruby image ONBUILD

This is the default image that you should actually reference in your service
Docker file

# USAGE

```docker
FROM influitive/ruby:onbuild

CMD ['rails', 'server']
```

This will:
1. install base ruby libs
2. install any rubygems needed for the app
3. add your application code to the image
