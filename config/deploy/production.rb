server 'hare.leap.se',
  roles:['app'],
  user:'website',
  port: 22,
  ssh_options: {
    auth_methods: ['publickey'],
    forward_agent: false
  }
