# Caliber

## What

Show CSS classes in your Rails application while working in development. Visit `http://localhost:3000/rails/info/css` and you can browse you application CSS files.

![Caliber Gem](http://cl.ly/image/201k050E1c0X/Image%202014-03-11%20at%207.45.52%20pm.png)


## Why?

Sometimes you would like to have a convenient way to search stylesheets in your application. That could be because you are using external libraries or SCSS mixins compile to a list of classes. Caliber gives you an easy interface to browse all CSS rules in your Rails application.

## Install

Add this to the development group in your Gemfile

```ruby
group :development do
  gem 'caliber'
end
```

Then run `bundle install` and you're ready to start

## Use

Visit `/rails/info/css` in your app and you'll see your stylesheets. It's that simple.


## About

If you have a question file an issue or find me on the Twitters [@antulik](http://twitter.com/antulik).

This project rocks and uses MIT-LICENSE.
