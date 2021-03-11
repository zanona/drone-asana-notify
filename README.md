# drone-asana-notify

[drone.io](https://drone.io) plugin for notifying tag deployments on Asana

#### Usage:

```yml
  - name: asana
    image: zanona/drone-asana-notify
    when: { event: tag }
    settings:
      project: { from_secret: ASANA_PROJECT } #project id .i.e: 1124575787711212
      token: { from_secret: ASANA_TOKEN } #get from https://app.asana.com/0/developer-console
```

Plugin will submit a `green` project status update with the contents of the tag
message. _.i.e: `git tag v1.2.3 -m 'Message here...'`_
