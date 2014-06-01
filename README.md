# Bill Scraper

Gather information about you bills without all the clicking and password memorization.

## Sample profile (config/profile.yml)

`````
---
- - :pge
  - :user: "foo"
    :password: "bar"
- - :att
  - :user: "john"
    :password: "doe"
    :passcode: 1234
`````

## Run IT!

`````
$ billscraper
pge	1/1/14	$99.95
att	1/15/14	$120.99
`````
