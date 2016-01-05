server 'www.vpzven.ru', user: 'deployer', port: 3501, roles: %w(web app db)
set :nginx_server_name, 'www.vpzven.ru'
set :ssh_options, keys: %w(/home/gambala/.ssh/id_rsa),
                  forward_agent: false,
                  auth_methods: %w(publickey)
